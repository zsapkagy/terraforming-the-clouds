data "aws_ami" "amazon_linux_2" {
  most_recent = true

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name = "name"
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

# data "cloudinit_config" "foo" {
#   gzip          = false
#   base64_encode = false

#   part {
#     content_type = "text/x-shellscript"
#     content      = "baz"
#     filename     = "foobar.sh"
#   }
# }

# data "cloudinit_config" "config" {
#   gzip          = false
#   base64_encode = false
#   part {
#     content_type = "text/cloud-config"
#     content = templatefile("${path.module}/init/cloud_init.yaml",
#       {
#         root               = path.module
#         AWS_CLI_access_key = "TODO"
#         AWS_CLI_secret_key = "TODO"
#         AWS_CLI_region     = "TODO"
#         GIT_PUB_KEY        = file("~/.ssh/github/for-ec2/id_ed25519.pub")
#         GIT_PRIVATE_KEY    = file("~/.ssh/github/for-ec2/id_ed25519")
#       }
#     )
#   }
#   part {
#     content_type = "text/x-shellscript"
#     content = templatefile("${path.module}/init/init.sh",
#       {
#         user = "ec2-user"
#     })
#     filename = "init.sh"
#   }
#   # part {
#   #   content_type = "text/x-shellscript"
#   #   filename     = "init-.sh"
#   #   content      = <<-EOL
#   #     #!/bin/bash
#   #     aws configure set aws_access_key_id ${var.AWS_CLI_access_key}
#   #     aws configure set aws_secret_access_key ${var.AWS_CLI_secret_key}
#   #     aws configure set default region ${var.AWS_CLI_region}
#   #   EOL
#   # }
# }

# data "template_file" "user_data" {
#   template = file("./scripts/init.yaml")

#   vars = {
#     AWS_CLI_access_key = "TODO"
#     AWS_CLI_secret_key = "TODO"
#     AWS_CLI_region     = "TODO"
#     GIT_PUB_KEY        = file("~/.ssh/github/for-ec2/id_ed25519.pub")
#     GIT_PRIVATE_KEY    = file("~/.ssh/github/for-ec2/id_ed25519")
#   }
# }

# data "cloudinit_config" "example" {
#   gzip          = false
#   base64_encode = false

#   part {
#     content_type = "text/cloud-config"
#     filename     = "cloud-config.yaml"
#     content      = local.cloud_config_config
#   }

#   part {
#     content_type = "text/x-shellscript"
#     filename     = "example.sh"
#     content  = <<-EOF
#       #!/bin/bash
#       echo "Hello World"
#     EOF
#   }
# }
