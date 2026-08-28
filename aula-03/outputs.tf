output "iam_users" {
  description = "Nomes dos usuarios IAM criados."
  value = {
    juliana = aws_iam_user.juliana_dev.name
    rafael  = aws_iam_user.rafael_platform.name
    lucas   = aws_iam_user.lucas_intern.name
  }
}

output "iam_groups" {
  description = "Nomes dos grupos IAM criados."
  value = {
    developers   = aws_iam_group.developers.name
    platform_eng = aws_iam_group.platform_eng.name
  }
}

output "policy_arns" {
  description = "ARNs das policies customizadas."
  value = {
    s3_read          = aws_iam_policy.s3_read.arn
    ec2_s3_full      = aws_iam_policy.ec2_s3_full.arn
    deny_destructive = aws_iam_policy.deny_destructive.arn
    ec2_app_data     = aws_iam_policy.ec2_app_data.arn
  }
}

output "ec2_role_arn" {
  description = "ARN do role que sera associado a instancias EC2."
  value       = aws_iam_role.ec2.arn
}

output "ec2_instance_profile_name" {
  description = "Nome do instance profile para uso na EC2."
  value       = aws_iam_instance_profile.ec2.name
}
