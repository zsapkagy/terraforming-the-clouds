variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "Type of the EC2 instance"
}

variable "aws_key_pair_public_key_file_path" {
  type        = string
  description = "The PEM file path that will be used to access the EC2 instance"
  sensitive   = true
}

variable "AWS_CLI_access_key" {
  type      = string
  sensitive = true
}
variable "AWS_CLI_secret_key" {
  type      = string
  sensitive = true
}
variable "AWS_CLI_region" {
  type      = string
  sensitive = true
}
variable "GIT_PUB_KEY" {
  type      = string
  sensitive = true
}
variable "GIT_PRIVATE_KEY" {
  type      = string
  sensitive = true
}
