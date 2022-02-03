module "aws-eks" {
  source                            = "./aws-eks"
  aws_key_pair_public_key_file_path = var.AWS_KEY_PAIR_PUBLIC_KEY_FILE_PATH
  GIT_PUB_KEY                       = file("~/.ssh/github/for-ec2/id_ed25519.pub")
  GIT_PRIVATE_KEY                   = file("~/.ssh/github/for-ec2/id_ed25519")
}
