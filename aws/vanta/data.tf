data "aws_iam_policy_document" "vanta_permissions" {
  statement {
    effect = "Allow"
    actions = [
      "codecommit:GetApprovalRuleTemplate",
      "codecommit:ListPullRequests",
      "codecommit:GetCommentsForPullRequest",
      "codecommit:GetPullRequest",
      "codecommit:GetPullRequestApprovalStates",
      "identitystore:DescribeGroup",
      "identitystore:DescribeGroupMembership",
      "identitystore:DescribeUser",
      "identitystore:GetGroupId",
      "identitystore:GetGroupMembershipId",
      "identitystore:GetUserId",
      "identitystore:IsMemberInGroups",
      "identitystore:ListGroupMemberships",
      "identitystore:ListGroups",
      "identitystore:ListUsers",
      "identitystore:ListGroupMembershipsForMember",
    ]
    resources = ["*"]
  }

  statement {
    effect = "Deny"
    actions = [
      "datapipeline:EvaluateExpression",
      "datapipeline:QueryObjects",
      "rds:DownloadDBLogFilePortion"
    ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = ["arn:aws:iam::${vanta_role}:role/scanner"]
      type        = "AWS"
    }
    condition {
      test     = "StringEquals"
      values   = ["48831EA4DBFBCDD"]
      variable = "sts:ExternalId"
    }
  }
}
