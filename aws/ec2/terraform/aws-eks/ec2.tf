module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = join("-", [local.name, "instance"])

  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = var.instance_type
  key_name      = aws_key_pair.access_key.key_name
  #   monitoring             = false
  vpc_security_group_ids = [module.security_group.security_group_id]
  # subnet_id              = "subnet-eddcdzz4"

  tags = merge({
    Name      = "AWS - Kubernetes"
    Terraform = "true"
    Target    = "AWS"
    SSH       = "true"
    Content   = "Kubectl, Github"
    },
    local.tags
  )

  # user_data = data.template_file.user_data.rendered
  user_data = data.cloudinit_config.config.rendered

  # user_data = <<-EOF
  #   #!/bin/bash
  #   echo test of user_data | sudo tee /tmp/user_data.log
  #   echo "Hello World.  The time is now $(date -R)!" | tee /root/output.txt
  # EOF

  depends_on = [
    module.security_group,
    aws_key_pair.access_key
  ]
}
