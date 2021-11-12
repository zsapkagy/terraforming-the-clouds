module "security_group" {
  source  = "terraform-aws-modules/security-group/aws//modules/ssh"
  version = "~> 4.0"

  name = join("-",[ local.name, "sg"])
  description = "Security group for EC2 instances"
  vpc_id      = data.aws_vpc.default.id

  ingress_cidr_blocks = ["0.0.0.0/0"]

  tags = local.tags
}