/*
aws_amplify_app provides an Amplify App resource, a fullstack serverless app hosted on the AWS Amplify Console.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/amplify_app
*/
resource "aws_amplify_app" "this" {
  name       = var.deploy_branch_name
  repository = var.repository

  access_token = var.github_token

  build_spec = <<-EOT
    version: 1
    applications:
    - appRoot: ${var.application_root}
      backend:
        phases:
          build:
            commands:
              - amplifyPush --simple
      frontend:
        phases:
          preBuild:
            commands:
              - ${var.install_command}
          build:
            commands:
              - ${var.build_command}
        artifacts:
          baseDirectory: ${var.base_artifacts_directory}
          files:
            - '**/*'
        cache:
          paths:
            - node_modules/**/*
  EOT

  dynamic "custom_rule" {
    for_each = var.custom_redirect_rules

    content {
      source = custom_rule.value.source
      target = custom_rule.value.target
      status = custom_rule.value.status
    }
  }

  platform              = var.web_platform
  iam_service_role_arn  = aws_iam_role.amplify_backend.arn
  environment_variables = var.build_variables
}

/*
aws_amplify_backend_environment provides an Amplify Backend Environment resource.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/amplify_backend_environment
*/
resource "aws_amplify_backend_environment" "this" {
  app_id           = aws_amplify_app.this.id
  environment_name = "backend"
}

/*
aws_amplify_branch provides an Amplify Branch resource.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/amplify_branch
*/
resource "aws_amplify_branch" "this" {
  app_id      = aws_amplify_app.this.id
  branch_name = var.deploy_branch_name

  stage                   = var.environment == "prod" ? "PRODUCTION" : "DEVELOPMENT"
  backend_environment_arn = aws_amplify_backend_environment.this.arn

  enable_auto_build = true
}

/*
aws_amplify_domain_association provides an Amplify Domain Association resource.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/amplify_domain_association
*/
resource "aws_amplify_domain_association" "this" {
  app_id                = aws_amplify_app.this.id
  domain_name           = "${var.sub_domain}.${var.dns_zone}"
  wait_for_verification = false

  sub_domain {
    branch_name = aws_amplify_branch.this.branch_name
    prefix      = ""
  }

  sub_domain {
    branch_name = aws_amplify_branch.this.branch_name
    prefix      = "www"
  }
}
