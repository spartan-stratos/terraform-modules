data "aws_iam_policy_document" "ecs_tasks_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["ecs-tasks.amazonaws.com"]
      type        = "Service"
    }

    effect = "Allow"
  }
}

resource "aws_iam_role" "task_execution_role" {
  name               = var.overwrite_task_execution_role_name != null ? var.overwrite_task_execution_role_name : "${var.name}-ecs-task-execution-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_tasks_assume_role.json
}

data "aws_iam_policy_document" "secrets" {
  statement {
    sid       = "AccessSecrets"
    effect    = "Allow"
    actions   = ["secretsmanager:GetSecretValue"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "secrets" {
  name        = "${var.name}-task-policy-secrets"
  description = var.task_policy_secrets_description
  policy      = data.aws_iam_policy_document.secrets.json
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_secrets_policy_attachment" {
  role       = aws_iam_role.task_execution_role.name
  policy_arn = aws_iam_policy.secrets.arn
}

data "aws_iam_policy_document" "ssm" {
  statement {
    sid       = "AccessSSM"
    effect    = "Allow"
    actions   = ["ssm:GetParameter", "ssm:GetParameters"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "ssm" {
  name        = "${var.name}-task-policy-ssm"
  description = var.task_policy_ssm_description
  policy      = data.aws_iam_policy_document.ssm.json
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_ssm_policy_attachment" {
  role       = aws_iam_role.task_execution_role.name
  policy_arn = aws_iam_policy.ssm.arn
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy_attachment" {
  count      = length(var.ecs_execution_policy_arns)
  role       = aws_iam_role.task_execution_role.name
  policy_arn = var.ecs_execution_policy_arns[count.index]
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_basic_role_policy_attachment" {
  role       = aws_iam_role.task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

data "aws_iam_policy_document" "task_role_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }

    effect = "Allow"
  }
}

resource "aws_iam_role" "task_role" {
  name               = var.overwrite_task_role_name != null ? var.overwrite_task_role_name : "${var.name}-ecs-task-role"
  assume_role_policy = data.aws_iam_policy_document.task_role_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "ecs_task_role_additional_policies_attachment" {
  count      = length(var.additional_iam_policy_arns)
  role       = aws_iam_role.task_role.name
  policy_arn = var.additional_iam_policy_arns[count.index]
}
