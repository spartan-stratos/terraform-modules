/*
aws_ecr_repository provides an Elastic Container Registry Repository.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository
*/
resource "aws_ecr_repository" "this" {
  name                 = var.name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }

  tags = var.tags
}

/*
aws_ecr_lifecycle_policy manages an ECR repository lifecycle policy.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_lifecycle_policy
*/
resource "aws_ecr_lifecycle_policy" "this" {
  repository = aws_ecr_repository.this.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 90
        description  = "keep last 50 images"
        action = {
          type = "expire"
        }
        selection = {
          tagStatus   = "any"
          countType   = "imageCountMoreThan"
          countNumber = 50
        }
      },
      {
        rulePriority = 10
        description  = "remove untagged images"
        action = {
          type = "expire"
        }
        selection = {
          tagStatus   = "untagged"
          countType   = "sinceImagePushed"
          countNumber = 1
          countUnit   = "days"
        }
      }
    ]
  })
}
