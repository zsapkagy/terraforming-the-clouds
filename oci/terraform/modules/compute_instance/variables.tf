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
  description = "The path to the SSH public key file This will be used to access the instance"
  type        = string
}

variable "subnet_id" {
  description = "The subnet ID for the instance."
  type        = string
}

variable "user_data" {
  description = "User data for instance initialization"
  type        = string
  sensitive   = true
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

variable "boot_volume_size" {
  description = "The size of the boot volume in GB."
  type        = number
  default     = 50 # Set a default value of 50GB
}

variable "persisted_block_volume_size" {
  description = "Size of the persisted block volume in GB. If not provided, no volume will be created."
  type        = number
  default     = null
}
