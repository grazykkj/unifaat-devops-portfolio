resource "aws_iam_group" "developers" {
  name = "${local.name_prefix}-developers"
  path = "/technova/"
}

resource "aws_iam_group" "platform_eng" {
  name = "${local.name_prefix}-platform-eng"
  path = "/technova/"
}

resource "aws_iam_user" "juliana_dev" {
  name = "${var.ra}-juliana-dev"
  path = "/technova/"
  tags = local.common_tags
}

resource "aws_iam_user" "rafael_platform" {
  name = "${var.ra}-rafael-platform"
  path = "/technova/"
  tags = local.common_tags
}

resource "aws_iam_user" "lucas_intern" {
  name = "${var.ra}-lucas-intern"
  path = "/technova/"
  tags = local.common_tags
}

resource "aws_iam_user_group_membership" "juliana" {
  user   = aws_iam_user.juliana_dev.name
  groups = [aws_iam_group.developers.name]
}

resource "aws_iam_user_group_membership" "rafael" {
  user   = aws_iam_user.rafael_platform.name
  groups = [aws_iam_group.developers.name, aws_iam_group.platform_eng.name]
}

resource "aws_iam_user_group_membership" "lucas" {
  user   = aws_iam_user.lucas_intern.name
  groups = [aws_iam_group.developers.name]
}
