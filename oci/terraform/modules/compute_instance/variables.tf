variable "availability_domain" {
  description = "The availability domain to launch instances in."
  type        = string
}

variable "compartment_id" {
  description = "The OCID of the compartment where the instances will be created."
  type        = string
}

variable "os_name" {
  description = "Operating system name"
  type        = string
  default     = "Canonical Ubuntu"
}

variable "os_version" {
  description = "Operating system version"
  type        = string
  default     = "24.04"
}

variable "os_user" {
  description = "Operating system user (ubuntu for Ubuntu OS, opc for Oracle)"
  type        = string
  default     = "ubuntu" // ubuntu, opc
}

variable "instance_shape" {
  description = "The shape of the instance"
  type        = string
  default     = "VM.Standard.E2.1.Micro"
}

variable "instance_name" {
  description = "The name of the instance"
  type        = string
}

variable "ocpus" {
  description = "The number of OCPUs"
  type        = number
  default     = 1
}

variable "memory_in_gbs" {
  description = "The amount of memory in GBs"
  type        = number
  default     = 1
}

variable "ssh_public_key_path" {
  description = "The path to the SSH public key file"
  type        = string
}

variable "subnet_id" {
  description = "The subnet ID for the instance."
  type        = string
}

variable "user_data" {
  description = "User data for instance initialization"
  type        = string
}

# Tag Variables
variable "project_name" {
  description = "Project name for resource tagging"
  type        = string
}

variable "environment" {
  description = "Environment tag"
  type        = string
  default     = "Development"
}

# GitHub Variables
variable "ssh_github_privatekey_path" {
  description = "The absolute path of the ssh private key that will be used to connect to the GitHub"
  type        = string
  sensitive   = true
}

variable "git_user_name" {
  description = "User name to the git config"
  type        = string
  sensitive   = true
}

variable "git_user_email" {
  description = "User email to the git config"
  type        = string
  sensitive   = true
}
