variable "aws_region" {
  type = string
}

variable "AWS_KEY_PAIR_PUBLIC_KEY_FILE_PATH" {
  type        = string
  description = "The PEM file path that has been registered in the AWS EC2 console to be used to access the EC2 instances through SSH (The ENV variable should have the TF_VAR_ prefix)"
}
