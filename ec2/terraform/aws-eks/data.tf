data "aws_ami" "amazon_linux_2" {
  most_recent = true

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    # values = ["amzn2-ami-hvm*"]
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  owners = ["amazon"]
}

#############################################################
# Data sources to get VPC and default security group details
#############################################################
data "aws_vpc" "default" {
  default = true
}