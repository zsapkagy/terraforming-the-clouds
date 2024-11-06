# Provider Variables

variable "region" {
  description = "The OCI region"
  type        = string
}

variable "compartment_id" {
  description = "The OCID of the compartment to create the instance in"
  type        = string
}

# Compute Instance Variables
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

# Network Variables
variable "vcn_name" {
  description = "Name of the VCN"
  type        = string
  default     = "terraform-vcn"
}

variable "vcn_dns_label" {
  description = "DNS label for the VCN"
  type        = string
  default     = "tfvcn"
}

variable "vcn_cidrs" {
  description = "CIDR blocks for the VCN"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "public_subnet_names" {
  description = "Names for public subnets"
  type        = list(string)
  default     = ["public-subnet"]
}

# Storage Variables
variable "state_bucket_name" {
  description = "Name of the bucket to store Terraform state"
  type        = string
  default     = "terraform-state-bucket"
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

# Github Variables

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
