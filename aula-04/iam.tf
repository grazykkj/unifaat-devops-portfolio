data "aws_iam_role" "lab_role" {
  name = "LabRole"
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "technova-ec2-profile"
  role = data.aws_iam_role.lab_role.name
}
