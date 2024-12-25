locals {
  private_cidr_blocks = cidrsubnet(var.cidr_block, 2, 0)
  public_cidr_blocks  = cidrsubnet(var.cidr_block, 2, 1)
}

/*
aws_vpc creates a Virtual Private Cloud (VPC) with DNS support and hostname resolution enabled.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
*/
resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.name}-vpc"
  }
}

/*
aws_internet_gateway attaches an internet gateway to the VPC for internet access.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway
*/
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.name}-igw"
  }
}

/*
aws_nat_gateway provides network address translation for private subnets.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway
*/
resource "aws_nat_gateway" "main" {
  count         = var.single_nat ? 1 : length(var.availability_zone_postfixes)
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id
  depends_on    = [aws_internet_gateway.main]

  tags = {
    Name = "${var.name}-nat-${format("%03d", count.index + 1)}"
  }
}

/*
aws_eip allocates Elastic IPs for NAT gateways, allowing static IP addresses for outbound internet access.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip
*/
resource "aws_eip" "nat" {
  count = var.single_nat ? 1 : length(var.availability_zone_postfixes)

  tags = {
    Name = "${var.name}-eip-${format("%03d", count.index + 1)}"
  }
}

/*
aws_subnet creates private subnets within the VPC for internal resources without direct internet access.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet
*/
resource "aws_subnet" "private" {
  count = length(var.availability_zone_postfixes)

  vpc_id            = aws_vpc.this.id
  cidr_block        = var.create_custom_subnets ? element(var.custom_private_subnets, count.index) : cidrsubnet(local.private_cidr_blocks, 8, count.index)
  availability_zone = "${var.region}${element(var.availability_zone_postfixes, count.index)}"

  tags = {
    Name = "${var.name}-private-subnet-${format("%03d", count.index + 1)}"
  }
}

/*
aws_subnet creates public subnets within the VPC with direct internet access.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet
*/
resource "aws_subnet" "public" {
  count = length(var.availability_zone_postfixes)

  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.create_custom_subnets ? element(var.custom_public_subnets, count.index) : cidrsubnet(local.public_cidr_blocks, 8, count.index)
  availability_zone       = "${var.region}${element(var.availability_zone_postfixes, count.index)}"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name}-public-subnet-${format("%03d", count.index + 1)}"
  }
}

/*
aws_route_table creates a routing table for public subnets to allow internet access.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
*/
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.name}-routing-table-public"
  }
}

/*
aws_route creates a default route to the internet gateway in the public route table.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route
*/
resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

/*
aws_route_table creates routing tables for private subnets with a NAT gateway for internet access.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
*/
resource "aws_route_table" "private" {
  count  = length(var.availability_zone_postfixes)
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.name}-routing-table-private-${format("%03d", count.index + 1)}"
  }
}

/*
aws_route creates a route to the NAT gateway in private route tables for outbound internet access.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route
*/
resource "aws_route" "private" {
  count                  = length(compact(var.availability_zone_postfixes))
  route_table_id         = aws_route_table.private[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = var.single_nat ? aws_nat_gateway.main[0].id : aws_nat_gateway.main[count.index].id
}

/*
aws_route_table_association associates private subnets with the private route tables for internal routing.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association
*/
resource "aws_route_table_association" "private" {
  count          = length(var.availability_zone_postfixes)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}

/*
aws_route_table_association associates public subnets with the public route table for internet access.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association
*/
resource "aws_route_table_association" "public" {
  count          = length(var.availability_zone_postfixes)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_flow_log" "this" {
  count = var.create_flow_log ? 1 : 0

  iam_role_arn    = aws_iam_role.vpc-flow-logs-role.arn
  log_destination = aws_cloudwatch_log_group.this.arn
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.this.id
}

resource "aws_cloudwatch_log_group" "this" {
  count = var.create_flow_log ? 1 : 0

  name = "${var.name}-cloudwatch-log-group"
}

resource "aws_iam_role" "vpc-flow-logs-role" {
  count = var.create_flow_log ? 1 : 0

  name               = "${var.name}-vpc-flow-logs-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "vpc-flow-logs-policy" {
  count = var.create_flow_log ? 1 : 0

  name   = "${var.name}-vpc-flow-logs-policy"
  role   = aws_iam_role.vpc-flow-logs-role.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
