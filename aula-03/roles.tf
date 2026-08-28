data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "ec2" {
  name               = "${local.name_prefix}-ec2-role"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json
  description        = "Role para instancias EC2 acessarem dados da aplicacao TechNova."
  tags               = local.common_tags
}

data "aws_iam_policy_document" "ec2_app_data" {
  statement {
    sid       = "ReadWriteApplicationData"
    effect    = "Allow"
    actions   = ["s3:GetObject", "s3:PutObject", "s3:ListBucket"]
    resources = ["arn:aws:s3:::technova-app-data-*", "arn:aws:s3:::technova-app-data-*/*"]
  }
}

resource "aws_iam_policy" "ec2_app_data" {
  name        = "${local.name_prefix}-ec2-app-data-rw"
  description = "Leitura e escrita apenas nos dados de aplicacao TechNova."
  policy      = data.aws_iam_policy_document.ec2_app_data.json
  tags        = local.common_tags
}

resource "aws_iam_role_policy_attachment" "ec2_app_data" {
  role       = aws_iam_role.ec2.name
  policy_arn = aws_iam_policy.ec2_app_data.arn
}

resource "aws_iam_instance_profile" "ec2" {
  name = "${local.name_prefix}-ec2-profile"
  role = aws_iam_role.ec2.name
  tags = local.common_tags
}
