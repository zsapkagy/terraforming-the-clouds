locals {
  name = "aws-eks"

  #   user_data = <<-EOT
  #   #!/bin/bash
  #   echo "Hello Terraform!"
  #   EOT

  tags = {
    Type = "workstation"
    # Environment = "dev"
  }
}
