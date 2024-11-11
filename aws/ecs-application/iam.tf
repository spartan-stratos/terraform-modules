resource "aws_iam_role" "task_execution_role" {
  name = "${var.name}-ecsTaskExecutionRole"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "secrets" {
  name        = "${var.name}-task-policy-secrets"
  description = "Policy that allows access to the secrets we created"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AccessSecrets",
            "Effect": "Allow",
            "Action": [
              "secretsmanager:GetSecretValue"
            ],
            "Resource": "*"
        }
    ]
}
EOF
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

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_secrets_policy_attachment" {
  role       = aws_iam_role.task_execution_role.name
  policy_arn = aws_iam_policy.secrets.arn
}

resource "aws_iam_policy" "ses_send_emails" {
  name        = "${var.name}-ses-send-emails-policy"
  description = "Policy that allows access to the secrets we created"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "SESSendEmails",
            "Effect": "Allow",
            "Action": [
              "ses:SendEmail"
            ],
            "Resource": [
              "arn:aws:ses:*:${var.shared_data.aws_account_id}:identity/*",
              "arn:aws:ses:*:${var.shared_data.aws_account_id}:template/*",
              "arn:aws:ses:*:${var.shared_data.aws_account_id}:configuration-set/*"
            ]
        }
    ]
}
EOF
}

resource "aws_iam_role" "task_role" {
  name = "${var.name}-ecsTaskRole"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ecs_task_role_additional_policies_attachment" {
  count      = length(var.additional_iam_policy_arns)
  role       = aws_iam_role.task_role.name
  policy_arn = var.additional_iam_policy_arns[count.index]
}

resource "aws_iam_role_policy_attachment" "ecs_task_role_ses_send_emails_policy_attachment" {
  role       = aws_iam_role.task_role.name
  policy_arn = aws_iam_policy.ses_send_emails.arn
}
