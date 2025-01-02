/*
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm
*/
resource "aws_cloudwatch_metric_alarm" "this" {
  for_each = var.alarms

  alarm_name          = each.value.name
  alarm_description   = each.value.description
  comparison_operator = each.value.comparison_operator
  evaluation_periods  = each.value.evaluation_periods
  metric_name         = each.value.metric_name
  namespace           = each.value.namespace
  period              = each.value.period
  statistic           = each.value.statistic
  threshold           = each.value.threshold
  alarm_actions       = var.create_sns_topic ? concat([aws_sns_topic.this[0].arn], var.sns_topic_arns) : var.sns_topic_arns
  datapoints_to_alarm = var.datapoints_to_alarm

  dimensions = merge(
    {},
    each.value.namespace == "AWS/SQS" ? { QueueName = each.value.queue_name } : {},
    each.value.namespace == "AWS/ApplicationELB" ?
    merge(
      { LoadBalancer = each.value.alb_name },
      each.value.target_group_name != null ? { TargetGroup = each.value.target_group_name } : {}
    )
    : {},
    each.value.namespace == "AWS/EC2" ? { InstanceId = each.value.instance_id } : {}
  )
}

/*
https://registry.terraform.io/providers/hashicorp/aws/2.48.0/docs/resources/sns_topic
*/
resource "aws_sns_topic" "this" {
  count = var.create_sns_topic ? 1 : 0
  name  = "Cloudwatch-Alarm-notification"
}

/*
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription
*/
resource "aws_sns_topic_subscription" "target" {
  topic_arn = var.create_sns_topic ? aws_sns_topic.this[0].arn : null
  protocol  = "email"
  endpoint  = var.email
}
