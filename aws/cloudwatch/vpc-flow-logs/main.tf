resource "aws_cloudwatch_log_group" "main" {
  name              = "${var.group_name}-cloudwatch-log-group"
  retention_in_days = var.retention_in_days
}

resource "aws_iam_role" "main" {
  name = "${var.group_name}-vpc-flow-logs-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "vpc-flow-logs.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "main" {
  name = "${var.group_name}-vpc-flow-logs-policy"
  role = aws_iam_role.main.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_flow_log" "main" {
  iam_role_arn         = aws_iam_role.main.arn
  log_destination      = aws_cloudwatch_log_group.main.arn
  traffic_type         = var.traffic_type
  log_destination_type = "cloud-watch-logs"
  vpc_id               = var.vpc_id
}
