module "this" {
  source = "../../"

  name                          = "example-service"
  environment                   = "dev"
  region                        = "us-west-2"
  subnet_ids                    = [] # the subnet objects should be passed
  security_group_ids            = ["sg-0ea3ae12345678"]
  additional_iam_policy_arns    = []
  container_port                = 8080
  container_cpu                 = 512
  container_memory              = 2048
  alb_dns_name                  = "example.us-west-2.elb.amazonaws.com"
  alb_security_groups           = ["sg-0ea3ae12345678"]
  alb_zone_id                   = "Z1H1FL5HABSF5" # us-west-2 hosted zone for ALB
  aws_lb_listener_arn           = "arn:aws:elasticloadbalancing:us-west-2:123456789012:loadbalancer/app/my-load-balancer/50dc6c495c0c9188"
  aws_lb_listener_rule_priority = 100
  container_environment = [
    {
      name  = "AWS_REGION",
      value = "us-west-2"
    },
    {
      name  = "LOG_LEVEL",
      value = "INFO"
    },
    {
      name  = "MICRONAUT_ENVIRONMENTS",
      value = "dev"
    },
    {
      name  = "PORT",
      value = 8080
    }
  ]
  container_secrets = [
    {
      name      = "DB_PASSWORD",
      valueFrom = "example"
    },
    {
      name      = "DD_API_KEY",
      valueFrom = "example"
    }
  ]
  container_image           = "1234567899.dkr.ecr.us-west-2.amazonaws.com/example:latest"
  dd_api_key_arn            = "example"
  dns_name                  = "example"
  ecs_cluster_id            = "example-cluster-id"
  ecs_cluster_name          = "example-cluster-name"
  ecs_execution_policy_arns = []
  route53_zone_id           = "example"
  vpc_id                    = "vpc-0131eae12345678"
  service_desired_count     = 2
  service_max_capacity      = 2
  shared_data = {
    aws_account_id = ""
    dd_agent_image = ""
    dd_site        = ""
  }

  additional_container_definitions = [
    {
      name        = "api-migration"
      image       = "1234567899.dkr.ecr.us-west-2.amazonaws.com/example:latest-migration"
      essential   = false
      cpu         = 10
      memory      = 256
      mountPoints = []
      volumesFrom = []
      environment = [
        {
          "name" : "ECS_FARGATE",
          "value" : "true"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "example-api-loggroup"
          awslogs-stream-prefix = "migration"
          awslogs-region        = "us-west-2"
        }
      }

      secrets = [
        {
          name      = "DB_PASSWORD"
          valueFrom = "example"
        }
      ]
    }
  ]
}
