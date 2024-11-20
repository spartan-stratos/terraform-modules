resource "aws_cloudwatch_log_group" "this" {
  name = "/ecs/${var.cluster_name}-cluster"

  tags = var.tags
}

resource "aws_ecs_cluster" "this" {
  name = "${var.cluster_name}-cluster"

  tags = var.tags
}
