import argparse
import json
import logging
import os
import shutil
import tempfile
from pathlib import Path
from typing import List

import git
import requests
from dotenv import load_dotenv
from git import Repo
from github import Github, GithubException

load_dotenv()

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

GH_APP_ID = os.getenv("GH_APP_ID")
GITHUB_ORG = os.getenv("GITHUB_ORG")
GITHUB_APP_INSTALLATION_ID = os.getenv("GITHUB_APP_INSTALLATION_ID")
# GH_APP_ID = '1393968'
GITHUB_TOKEN = os.getenv("GITHUB_TOKEN")
X_CSRF_TOKEN = os.getenv("X_CSRF_TOKEN")
AUTH_COOKIE_KEY = os.getenv("AUTH_COOKIE_KEY")
AUTH_COOKIE_VALUE = os.getenv("AUTH_COOKIE_VALUE")

if not GITHUB_TOKEN:
    raise EnvironmentError("The 'GITHUB_TOKEN' environment variable is not set.")

CONFIG = {
    "enable_branch_protection": False,
    "enable_tag_protection": False,
    "setup_actions_secrets": True,
    "trigger_release_workflow": True,
    "enabled_publishing": False,
    "skip_published_modules": False,
}


class TerraformModulePublisher:
    def __init__(
            self, github_token: str, org_name: str, base_dir: str
    ):
        self.github_token = github_token
        self.github_client = Github(github_token)
        self.provider_folders = ['aws', 'datadog', 'gcp', 'github']
        self.template_dir = os.path.join(os.getcwd(), 'template')
        self.base_dir = base_dir
        self.org_name = org_name

        # Get organization
        try:
            self.org = self.github_client.get_organization(org_name)
            logger.info(f"Successfully connected to organization: {org_name}")
        except GithubException as e:
            logger.error(f"Failed to access organization {org_name}: {str(e)}")
            raise

        # Cache for checking repositories
        self._org_repos = None

    def _get_org_repos(self) -> set:
        """Cache and return organization's repositories names"""
        if self._org_repos is None:
            self._org_repos = {repo.name for repo in self.org.get_repos()}
        return self._org_repos

    def repository_exists(self, repo_name: str) -> bool:
        """Check if repository already exists"""
        return repo_name in self._get_org_repos()

    def create_github_repo(self, repo_name):
        """Create a new GitHub repository with specific settings"""
        try:
            logger.info(f"Attempting to create repository '{repo_name}' in organization '{self.org.login}'.")

            repo = self.org.create_repo(
                name=repo_name,
                private=False
            )

            # Update repository settings
            repo.edit(
                allow_squash_merge=True,
                use_squash_pr_title_as_default=True,
                squash_merge_commit_title='PR_TITLE',
                allow_merge_commit=False,
                allow_rebase_merge=False,
                delete_branch_on_merge=True,
            )

            return repo
        except Exception as e:
            logger.error(f"Error creating repository {repo_name}: {str(e)}", exc_info=True)
            raise

    def setup_branch_protection(self, repo, protection_rules_file='branch_protection.json'):
        """Setup branch protection rules from JSON file"""
        try:
            rulesets_dir = os.path.join(os.getcwd(), 'rulesets')
            protection_rules_path = os.path.join(rulesets_dir, protection_rules_file)

            if os.path.exists(protection_rules_path):
                with open(protection_rules_path, 'r') as f:
                    rules = json.load(f)

                headers = {
                    "Authorization": f"Bearer {self.github_token}",
                    "Accept": "application/vnd.github+json"
                }

                # Make the API request to create the ruleset
                api_url = f"https://api.github.com/repos/{self.org_name}/{repo.name}/rulesets"
                logger.info(f"Setting up branch protection rules for {repo.name} using url: {api_url}")
                requests.post(api_url, headers=headers, json=rules)
                logger.info(f"Branch protection rules applied for {repo.name}")
            else:
                logger.warning(f"Branch protection file '{protection_rules_path}' does not exist.")
        except Exception as e:
            logger.error(f"Error setting up branch protection: {str(e)}", exc_info=True)

    def setup_tag_protection(self, repo, tag_rules_file='tag_protection.json'):
        """Setup tag protection rules from JSON file"""
        try:
            rulesets_dir = os.path.join(os.getcwd(), 'rulesets')
            tag_rules_path = os.path.join(rulesets_dir, tag_rules_file)

            if os.path.exists(tag_rules_path):
                with open(tag_rules_path, 'r') as f:
                    rules = json.load(f)

                headers = {
                    "Authorization": f"Bearer {self.github_token}",
                    "Accept": "application/vnd.github+json"
                }

                # Make the API request to create the ruleset
                api_url = f"https://api.github.com/repos/{self.org_name}/{repo.name}/rulesets"

                # Step 1: Check if any rulesets exist
                get_response = requests.get(api_url, headers=headers)
                existing_rulesets = get_response.json()
                ruleset_id = None

                if get_response.status_code == 200:
                    # Step 2: Look for existing rulesets matching the policy name in the payload
                    for ruleset in existing_rulesets:
                        if ruleset.get("name") == rules.get("name"):
                            ruleset_id = ruleset.get("id")
                            break

                if ruleset_id is None:
                    response = requests.post(api_url, headers=headers, json=rules)
                    logger.info(f"Tag protection rules creation response: {response.text}")
                else:
                    response = requests.put(f"{api_url}/{ruleset_id}", headers=headers, json=rules)
                    logger.info(f"Tag protection rules updating response: {response.text}")

                logger.info(f"Tag protection rules response: {response.text}")
                logger.info(f"Tag protection rules applied for {repo.name}")
            else:
                logger.warning(f"Tag protection file '{tag_rules_path}' does not exist.")
        except Exception as e:
            logger.error(f"Error setting up tag protection: {str(e)}", exc_info=True)

    def setup_github_actions_credentials(self, repo):
        logger.info(f"Setting up GitHub Actions credentials for repository: {repo.name}")

        # Read the value for the secret `GH_APP_PRIVATE_KEY` from the credentials folder
        secret_file_path = os.path.join(os.getcwd(), "credentials", "github_app_private_key.pem")
        try:
            with open(secret_file_path, "r") as file:
                gh_app_private_key = file.read()
        except FileNotFoundError:
            logger.error(f"Secret file not found at {secret_file_path}")
            return

        repo.create_secret(secret_name="GH_APP_PRIVATE_KEY", unencrypted_value=gh_app_private_key)
        logger.info("Secret 'GH_APP_PRIVATE_KEY' successfully created.")

        # ----- Step 2: Set up the variable `GH_APP_ID` -----
        try:
            # Get the list of existing variables to check if the variable already exists
            existing_variables = repo.get_variables()
            existing_variable = next((var for var in existing_variables if var.name == "GH_APP_ID"), None)

            if existing_variable and existing_variable != GH_APP_ID:
                repo.delete_variable(variable_name="GH_APP_ID")
                repo.create_variable(variable_name="GH_APP_ID", value=GH_APP_ID)
                logger.info("Variable 'GH_APP_ID' successfully recreated due to value mismatch.")
            else:
                repo.create_variable(variable_name="GH_APP_ID", value=GH_APP_ID)
                logger.info("Variable 'GH_APP_ID' successfully created.")

            # Create the variable (either fresh or after deletion)
        except Exception as e:
            logger.error(f"Error setting the variable 'GH_APP_ID': {e}", exc_info=True)

    def trigger_release_workflow(self, repo):
        logger.info(f"Triggering 'Release' workflow for repository: {repo.name}")

        # Endpoint to fetch the repository tags
        tags_url = f"https://api.github.com/repos/{self.org_name}/{repo.name}/tags"

        # Fetch tags (no authorization needed for public repositories)
        response = requests.get(tags_url)

        # Handle the response for fetching tags
        if response.status_code == 200:  # 200 means success
            tags = response.json()
            if tags:  # If there are any existing tags, skip triggering the workflow
                logger.info(f"Skipping 'Release' workflow trigger for repository: {repo.name} as tags already exist.")
                return
            else:
                logger.info(f"No tags found for repository: {repo.name}, proceeding to trigger 'Release' workflow.")
        else:
            logger.error(
                f"Failed to fetch tags for repository: {repo.name}. "
                f"Status Code: {response.status_code}, Response: {response.text}"
            )
            return

        # Workflow file name to trigger
        workflow_file_name = "release.yml"

        # Define the dispatch endpoint
        dispatch_url = f"https://api.github.com/repos/{self.org_name}/{repo.name}/actions/workflows/{workflow_file_name}/dispatches"

        # Data payload for workflow dispatch
        payload = {
            "ref": "master"
        }

        # Headers for the API call
        headers = {
            "Authorization": f"token {self.github_token}",  # Use the token provided in the class
            "Accept": "application/vnd.github+json"
        }

        # Make the POST request to trigger the workflow
        response = requests.post(dispatch_url, headers=headers, json=payload)

        # Handle the response
        if response.status_code == 204:  # 204 means success with no content
            logger.info(f"Successfully triggered 'Release' workflow for repository: {repo.name}")
        else:
            logger.error(
                f"Failed to trigger 'Release' workflow for repository: {repo.name}. "
                f"Status Code: {response.status_code}, Response: {response.text}"
            )

    def is_module_published(self, module_name, namespace, provider):
        try:
            # Terraform public registry base URL for searching modules
            api_url = f"https://registry.terraform.io/v1/modules/{namespace}/{module_name}/{provider}"

            response = requests.get(api_url)

            logger.info(
                f"Check module publication status for {namespace}/{module_name}/{provider} using url: {api_url} - response: {response.status_code}")

            # If response code is 200, the module exists
            if response.status_code == 200:
                logger.info(
                    f"Module '{namespace}/{module_name}/{provider}' is published in the Terraform public registry.")
                return True
            elif response.status_code == 404:
                logger.info(
                    f"Module '{namespace}/{module_name}/{provider}' is not published in the Terraform public registry.")
                return False
            else:
                logger.error(f"Unexpected status code {response.status_code} received from Terraform registry.")
                return False

        except requests.RequestException as e:
            logger.error(f"An error occurred while checking the module's publication status: {e}", exc_info=True)
            return False

    def publish_to_terraform_public_registry(self, repo):
        headers = {
            "Content-Type": "application/vnd.api+json",
            "x-csrf-token": X_CSRF_TOKEN
        }

        cookies = {
            AUTH_COOKIE_KEY: AUTH_COOKIE_VALUE
        }

        registry_url = f"https://app.terraform.io/api/v2/organizations/{self.org_name}/registry/modules"

        # Construct the request payload
        payload = {
            "data": {
                "attributes": {
                    "vcs_repo": {
                        "identifier": f"{self.org_name}/{repo.name}",
                        "github_app_installation_id": GITHUB_APP_INSTALLATION_ID,
                    }
                },
                "organization_name": self.org_name
            }
        }

        try:
            logger.info(
                f"Publishing module to Terraform Cloud Public Registry using repo: {repo.name} with url: {registry_url}")
            response = requests.post(registry_url, headers=headers, cookies=cookies, json=payload)

            if response.status_code == 201:  # HTTP 201 Created
                logger.info("Module successfully published to the Terraform Cloud registry.")
                return response.json()
            elif response.status_code == 422:  # HTTP 422 Unprocessable Entity
                logger.error("Module is already published or validation failed.")
                logger.error(f"Details: {response.text}")
            elif response.status_code == 401:  # HTTP 401 Unauthorized
                logger.error("Invalid Terraform Cloud API token.")
            else:
                logger.error(f"Failed to publish module. Response: {response.text}")
        except Exception as e:
            logger.error(f"An error occurred while publishing to Terraform Cloud: {e}", exc_info=True)

    def process_module(self, provider: str, module_name: str, module_path: str) -> dict:
        """Process a single Terraform module"""
        repo_name = f"terraform-{provider}-{module_name}"
        logger.info(f"Processing module: {repo_name}")

        result = {
            'provider': provider,
            'module': module_name,
            'repo_name': repo_name,
            'status': 'skipped',
            'message': ''
        }

        try:
            if (CONFIG['skip_published_modules']
                    and self.is_module_published(
                        namespace=self.org_name,
                        provider=provider,
                        module_name=module_name
                    )
            ):
                logger.info(f"Skipping module {module_name}: Already published in the Terraform public registry.")
                result.update({
                    'status': 'skipped',
                    'message': 'Module has already been published'
                })
                return result

            if self.repository_exists(repo_name):
                repo = self.org.get_repo(name=repo_name)
            else:
                repo = self.create_github_repo(repo_name)

            with tempfile.TemporaryDirectory() as temp_dir:
                # Clone the new repository
                repo_path = os.path.join(temp_dir, repo_name)

                if os.path.exists(repo_path):
                    shutil.rmtree(repo_path)

                repo_clone = Repo.clone_from(repo.ssh_url, repo_path)
                logger.info(f"Cloned repository {repo_name} to {repo_path} using url: {repo.ssh_url}")

                # Copy module files
                self.copy_module_files(module_path, repo_path)

                # Copy template files if they exist
                if os.path.exists(self.template_dir):
                    self.copy_template_files(repo_path)

                # Git operations
                repo_clone.git.add(A=True)
                repo_clone.index.commit("Initial commit")
                repo_clone.git.push('origin', 'master')

                # Setup protection rules
                if CONFIG["enable_branch_protection"]:
                    self.setup_branch_protection(repo)

                if CONFIG["enable_tag_protection"]:
                    self.setup_tag_protection(repo)

                if CONFIG["setup_actions_secrets"]:
                    self.setup_github_actions_credentials(repo)

                if CONFIG["trigger_release_workflow"]:
                    self.trigger_release_workflow(repo)

                if CONFIG["enabled_publishing"]:
                    self.publish_to_terraform_public_registry(repo)

            logger.info(f"Successfully processed module: {repo_name}")
            result.update({
                'status': 'success',
                'repo_url': repo.html_url,
                'message': 'Successfully created and configured repository'
            })

        except GithubException as e:
            message = f"GitHub API error processing module: {str(e)}"
            logger.error(message)
            result.update({
                'status': 'error',
                'message': message
            })
        except git.GitError as e:
            message = f"Git error processing module: {str(e)}"
            logger.error(message)
            result.update({
                'status': 'error',
                'message': message
            })
        except IOError as e:
            message = f"IO error processing module: {str(e)}"
            logger.error(message)
            result.update({
                'status': 'error',
                'message': message
            })

        return result

    def scan_and_process_modules(self) -> List[dict]:
        """Scan through provider folders and process modules"""
        results = []

        for provider in self.provider_folders:
            provider_path = os.path.join(self.base_dir, provider)

            logger.info(f"List modules in provider folder: {os.listdir(provider_path)}")

            for module_name in os.listdir(provider_path):
                module_path = os.path.join(provider_path, module_name)

                if os.path.isdir(module_path):
                    result = self.process_module(provider, module_name, module_path)
                    results.append(result)

        return results

    def copy_module_files(self, source_path, destination_path):
        """Copy module files to the destination repository"""
        try:
            for item in os.listdir(source_path):
                source_item = os.path.join(source_path, item)
                dest_item = os.path.join(destination_path, item)

                if os.path.isfile(source_item):
                    if os.path.isfile(dest_item):
                        os.remove(dest_item)
                    shutil.copy2(source_item, dest_item)
                elif os.path.isdir(source_item):
                    if os.path.isdir(dest_item):
                        shutil.rmtree(dest_item)
                    shutil.copytree(source_item, dest_item)

            logger.info(f"Module files copied successfully to {destination_path}")
        except Exception as e:
            logger.error(f"Error copying module files: {str(e)}", exc_info=True)
            raise

    def copy_template_files(self, destination_path):
        """Copy template files to the destination repository"""
        try:
            for item in os.listdir(self.template_dir):
                source_item = os.path.join(self.template_dir, item)
                dest_item = os.path.join(destination_path, item)

                if os.path.isfile(source_item):
                    if os.path.isfile(dest_item):
                        os.remove(dest_item)
                    shutil.copy2(source_item, dest_item)
                elif os.path.isdir(source_item):
                    if os.path.isdir(dest_item):
                        shutil.rmtree(dest_item)
                    shutil.copytree(source_item, dest_item)

            logger.info(f"Template files copied successfully to {destination_path}")
        except Exception as e:
            logger.error(f"Error copying template files: {str(e)}", exc_info=True)
            raise


def parse_arguments():
    parser = argparse.ArgumentParser(
        description='Terraform Module Publisher - Create GitHub repositories for Terraform modules')
    parser.add_argument(
        '--base-dir',
        type=str,
        default=os.getcwd(),
        help='Base directory containing the provider folders and template directory (default: current working directory)'
    )
    return parser.parse_args()


def validate_base_dir(base_dir: str) -> None:
    """Validate the base directory structure"""
    base_path = Path(base_dir)

    if not base_path.is_dir():
        raise ValueError(f"Base directory does not exist: {base_dir}")

    # Check for at least one provider directory
    provider_exists = False
    for provider in ['aws', 'datadog', 'gcp', 'github']:
        if (base_path / provider).is_dir():
            provider_exists = True
            break

    if not provider_exists:
        raise ValueError(
            f"No provider directories found in {base_dir}. Expected at least one of: aws, datadog, gcp, github")


def main():
    args = parse_arguments()
    base_dir = os.path.abspath(args.base_dir)

    try:
        validate_base_dir(base_dir)

        logger.info(f"Using base directory: {base_dir}")
        publisher = TerraformModulePublisher(
            github_token=GITHUB_TOKEN, org_name=GITHUB_ORG, base_dir=base_dir
        )
        results = publisher.scan_and_process_modules()

        # Print results
        print("\nProcessing Results:")
        print("==================")

        # Group results by status
        status_groups = {
            'success': [],
            'skipped': [],
            'error': []
        }

        for result in results:
            status_groups[result['status']].append(result)

        # Print successful results
        if status_groups['success']:
            print("\n✅ Successfully processed:")
            for result in status_groups['success']:
                print(f"  - {result['repo_name']}")
                print(f"    URL: {result['repo_url']}")

        # Print skipped results
        if status_groups['skipped']:
            print("\n⏭️  Skipped:")
            for result in status_groups['skipped']:
                print(f"  - {result['repo_name']}: {result['message']}")

        # Print errors
        if status_groups['error']:
            print("\n❌ Errors:")
            for result in status_groups['error']:
                print(f"  - {result['repo_name']}: {result['message']}")

        # Print summary
        print("\nSummary:")
        print(f"Base directory: {base_dir}")
        print(f"Total modules processed: {len(results)}")
        print(f"Successful: {len(status_groups['success'])}")
        print(f"Skipped: {len(status_groups['skipped'])}")
        print(f"Errors: {len(status_groups['error'])}")

    except Exception as e:
        logger.error(f"Error in main execution: {str(e)}", exc_info=True)
        raise


if __name__ == "__main__":
    main()
