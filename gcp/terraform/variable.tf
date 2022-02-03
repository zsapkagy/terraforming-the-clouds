variable "region" {
  description = "The GCP region to create and test resources in"
  type        = string
  default     = "europe-west6-a"
}

variable "zone" {
  description = "The GCP zone to create and test resources in"
  type        = string
  default     = "europe-west6-a"
}

variable "project_id" {
  description = "The GCP project to use"
  type        = string
}

variable "machine_type" {
  description = "The machine type to create"
  type        = string
  default     = "e2-medium"
}

variable "instance_name" {
  description = "The name of the instance"
  type        = string
}

variable "user" {
  description = "The SSH user"
  type        = string
}

variable "ssh_publickey_path" {
  description = "The absolute path of the ssh public key that will be used to connect the instance"
  type        = string
}

variable "git_user_name" {
  description = "User name to the git config"
  type        = string
}

variable "git_user_email" {
  description = "User email to the git config"
  type        = string
}
