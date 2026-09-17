resource "aws_key_pair" "technova" {
  key_name   = var.key_name
  public_key = file("~/.ssh/technova-key.pub")

  tags = merge(
    local.common_tags,
    {
      Name = "technova-key"
    }
  )
}
resource "aws_instance" "api" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"

  subnet_id = aws_subnet.public_a.id

  vpc_security_group_ids = [
    aws_security_group.api.id
  ]

  key_name = aws_key_pair.technova.key_name

  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  user_data = file("${path.module}/user-data.sh")

  tags = merge(
    local.common_tags,
    {
      Name = "technova-api-ec2"
    }
  )
}
