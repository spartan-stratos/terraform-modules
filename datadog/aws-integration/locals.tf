locals {
  datadog_aws_account_id = "464622532012"

  aws_services_enabled = {
    "api_gateway"                    = false
    "application_elb"                = false
    "apprunner"                      = false
    "appstream"                      = false
    "appsync"                        = false
    "athena"                         = false
    "auto_scaling"                   = false
    "backup"                         = false
    "bedrock"                        = false
    "billing"                        = false
    "budgeting"                      = false
    "certificatemanager"             = false
    "cloudfront"                     = false
    "cloudhsm"                       = false
    "cloudsearch"                    = false
    "cloudwatch_events"              = false
    "cloudwatch_logs"                = false
    "codebuild"                      = false
    "codewhisperer"                  = false
    "cognito"                        = false
    "collect_custom_metrics"         = false
    "connect"                        = false
    "crawl_alarms"                   = false
    "directconnect"                  = false
    "dms"                            = false
    "documentdb"                     = false
    "dynamodb"                       = false
    "dynamodbaccelerator"            = false
    "ebs"                            = false
    "ec2"                            = false
    "ec2api"                         = false
    "ec2spot"                        = false
    "ecr"                            = false
    "ecs"                            = false
    "efs"                            = false
    "elasticache"                    = true
    "elasticbeanstalk"               = false
    "elasticinference"               = false
    "elastictranscoder"              = false
    "elb"                            = false
    "emr"                            = false
    "es"                             = false
    "firehose"                       = false
    "fsx"                            = false
    "gamelift"                       = false
    "glue"                           = false
    "inspector"                      = false
    "iot"                            = false
    "keyspaces"                      = false
    "kinesis"                        = false
    "kinesis_analytics"              = false
    "kms"                            = false
    "lambda"                         = false
    "lex"                            = false
    "mediaconnect"                   = false
    "mediaconvert"                   = false
    "medialive"                      = false
    "mediapackage"                   = false
    "mediastore"                     = false
    "mediatailor"                    = false
    "ml"                             = false
    "mq"                             = false
    "msk"                            = false
    "mwaa"                           = false
    "nat_gateway"                    = false
    "neptune"                        = false
    "network_elb"                    = false
    "networkfirewall"                = false
    "opsworks"                       = false
    "polly"                          = false
    "privatelinkendpoints"           = false
    "privatelinkservices"            = false
    "rds"                            = true
    "rdsproxy"                       = false
    "redshift"                       = false
    "rekognition"                    = false
    "route53"                        = false
    "route53resolver"                = false
    "s3"                             = false
    "s3storagelens"                  = false
    "sagemaker"                      = false
    "sagemakerendpoints"             = false
    "sagemakerlabelingjobs"          = false
    "sagemakermodelbuildingpipeline" = false
    "sagemakerprocessingjobs"        = false
    "sagemakertrainingjobs"          = false
    "sagemakertransformjobs"         = false
    "sagemakerworkteam"              = false
    "service_quotas"                 = false
    "ses"                            = false
    "shield"                         = false
    "sns"                            = false
    "sqs"                            = false
    "step_functions"                 = false
    "storage_gateway"                = false
    "swf"                            = false
    "textract"                       = false
    "transitgateway"                 = false
    "translate"                      = false
    "trusted_advisor"                = false
    "usage"                          = false
    "vpn"                            = false
    "waf"                            = false
    "wafv2"                          = false
    "workspaces"                     = false
    "xray"                           = false
  }

  datadog_permissions = [
    "apigateway:GET",
    "autoscaling:Describe*",
    "backup:List*",
    "budgets:ViewBudget",
    "cloudfront:GetDistributionConfig",
    "cloudfront:ListDistributions",
    "cloudtrail:DescribeTrails",
    "cloudtrail:GetTrailStatus",
    "cloudtrail:LookupEvents",
    "cloudwatch:Describe*",
    "cloudwatch:Get*",
    "cloudwatch:List*",
    "codedeploy:List*",
    "codedeploy:BatchGet*",
    "directconnect:Describe*",
    "dynamodb:List*",
    "dynamodb:Describe*",
    "ec2:Describe*",
    "ec2:GetTransitGatewayPrefixListReferences",
    "ec2:SearchTransitGatewayRoutes",
    "ecs:Describe*",
    "ecs:List*",
    "elasticache:Describe*",
    "elasticache:List*",
    "elasticfilesystem:DescribeFileSystems",
    "elasticfilesystem:DescribeTags",
    "elasticfilesystem:DescribeAccessPoints",
    "elasticloadbalancing:Describe*",
    "elasticmapreduce:List*",
    "elasticmapreduce:Describe*",
    "elasticache:DescribeCacheClusters",
    "elasticache:ListTagsForResource",
    "elasticache:DescribeEvents",
    "es:ListTags",
    "es:ListDomainNames",
    "es:DescribeElasticsearchDomains",
    "events:CreateEventBus",
    "fsx:DescribeFileSystems",
    "fsx:ListTagsForResource",
    "health:DescribeEvents",
    "health:DescribeEventDetails",
    "health:DescribeAffectedEntities",
    "kinesis:List*",
    "kinesis:Describe*",
    "lambda:GetPolicy",
    "lambda:List*",
    "logs:DeleteSubscriptionFilter",
    "logs:DescribeLogGroups",
    "logs:DescribeLogStreams",
    "logs:DescribeSubscriptionFilters",
    "logs:FilterLogEvents",
    "logs:PutSubscriptionFilter",
    "logs:TestMetricFilter",
    "organizations:Describe*",
    "organizations:List*",
    "rds:Describe*",
    "rds:List*",
    "rds:DescribeDBInstances",
    "rds:ListTagsForResource",
    "rds:DescribeEvents",
    "redshift:DescribeClusters",
    "redshift:DescribeLoggingStatus",
    "route53:List*",
    "s3:GetBucketLogging",
    "s3:GetBucketLocation",
    "s3:GetBucketNotification",
    "s3:GetBucketTagging",
    "s3:ListAllMyBuckets",
    "s3:PutBucketNotification",
    "ses:Get*",
    "sns:List*",
    "sns:Publish",
    "sqs:ListQueues",
    "states:ListStateMachines",
    "states:DescribeStateMachine",
    "support:DescribeTrustedAdvisor*",
    "support:RefreshTrustedAdvisorCheck",
    "tag:GetResources",
    "tag:GetTagKeys",
    "tag:GetTagValues",
    "xray:BatchGetTraces",
    "xray:GetTraceSummaries"
  ]
}
