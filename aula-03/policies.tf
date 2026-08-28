data "aws_iam_policy_document" "s3_read" {
  statement {
    sid       = "ListTechNovaBuckets"
    effect    = "Allow"
    actions   = ["s3:ListBucket"]
    resources = ["arn:aws:s3:::technova-*"]
  }

  statement {
    sid       = "ReadTechNovaObjects"
    effect    = "Allow"
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::technova-*/*"]
  }
}

resource "aws_iam_policy" "s3_read" {
  name        = "${local.name_prefix}-s3-read"
  description = "Leitura limitada aos buckets S3 da TechNova."
  policy      = data.aws_iam_policy_document.s3_read.json
  tags        = local.common_tags
}

data "aws_iam_policy_document" "ec2_s3_full" {
  statement {
    sid       = "DescribeEc2"
    effect    = "Allow"
    actions   = ["ec2:DescribeInstances", "ec2:DescribeInstanceStatus", "ec2:DescribeTags"]
    resources = ["*"]
  }

  statement {
    sid       = "OperateTaggedEc2Only"
    effect    = "Allow"
    actions   = ["ec2:StartInstances", "ec2:StopInstances"]
    resources = ["arn:aws:ec2:${var.aws_region}:*:instance/*"]

    condition {
      test     = "StringEquals"
      variable = "ec2:ResourceTag/Project"
      values   = ["TechNova"]
    }
  }

  statement {
    sid       = "ManageTechNovaS3Objects"
    effect    = "Allow"
    actions   = ["s3:GetObject", "s3:PutObject", "s3:ListBucket"]
    resources = ["arn:aws:s3:::technova-*", "arn:aws:s3:::technova-*/*"]
  }
}

resource "aws_iam_policy" "ec2_s3_full" {
  name        = "${local.name_prefix}-ec2-s3-full"
  description = "Operacao limitada de EC2 com tag TechNova e acesso S3 do projeto."
  policy      = data.aws_iam_policy_document.ec2_s3_full.json
  tags        = local.common_tags
}

data "aws_iam_policy_document" "deny_destructive" {
  statement {
    sid       = "DenyDestructiveActions"
    effect    = "Deny"
    actions   = ["s3:Delete*", "ec2:TerminateInstances"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "deny_destructive" {
  name        = "${local.name_prefix}-deny-destructive"
  description = "Barreira explicita contra exclusoes e termino de instancias."
  policy      = data.aws_iam_policy_document.deny_destructive.json
  tags        = local.common_tags
}

resource "aws_iam_group_policy_attachment" "developers_s3_read" {
  group      = aws_iam_group.developers.name
  policy_arn = aws_iam_policy.s3_read.arn
}

resource "aws_iam_group_policy_attachment" "developers_deny_destructive" {
  group      = aws_iam_group.developers.name
  policy_arn = aws_iam_policy.deny_destructive.arn
}

resource "aws_iam_group_policy_attachment" "platform_ec2_s3" {
  group      = aws_iam_group.platform_eng.name
  policy_arn = aws_iam_policy.ec2_s3_full.arn
}
