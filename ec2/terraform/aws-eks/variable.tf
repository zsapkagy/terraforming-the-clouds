variable "instance_type" {
  type = string
  default = "t2.micro"
  description = "Type of the EC2 instance"
}

variable "aws_key_pair_public_key_file_path" {
  type = string
  description = "The PEM file path that will be used to access the EC2 instance"
}