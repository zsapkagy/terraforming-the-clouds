variable "region" {
  description = "The GCP region to create and test resources in"
  type        = string
  default     = "europe-west1"
}

variable "zone" {
  description = "The GCP zone to create and test resources in"
  type        = string
  default     = "europe-west1-b"
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

variable "ssh_github_privatekey_path" {
  description = "The absolute path of the ssh private key that will be used to connect to the GitHub"
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

variable "disk_size_gb" {
  description = "The boot disk size of the Compute instance"
  type        = number
  default     = 50
}
