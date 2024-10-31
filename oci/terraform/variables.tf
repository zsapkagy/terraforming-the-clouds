variable "tenancy_ocid" {
  description = "The OCID of your tenancy"
  type        = string
}

variable "user_ocid" {
  description = "The OCID of the user"
  type        = string
}

variable "fingerprint" {
  description = "The fingerprint of the API key"
  type        = string
}

variable "private_key_path" {
  description = "The path to the private key file"
  type        = string
}

variable "region" {
  description = "The OCI region"
  type        = string
}

variable "compartment_id" {
  description = "The OCID of the compartment to create the instance in"
  type        = string
}

# variable "instance_shape" {
#   description = "The shape of the instance"
#   type        = string
#   default     = "VM.Standard.E2.1.Micro"  // Free tier shape
# }

# variable "ocpus" {
#   description = "The number of OCPUs"
#   type        = number
#   default     = 0.125  // 1/8 OCPU for free tier
# }

# variable "memory_in_gbs" {
#   description = "The amount of memory in GBs"
#   type        = number
#   default     = 1  // 1 GB for free tier
# }

# variable "subnet_id" {
#   description = "The OCID of the subnet to create the VNIC in"
#   type        = string
# }

# variable "image_id" {
#   description = "The OCID of the image to use for the instance"
#   type        = string
# }

# variable "ssh_public_key_path" {
#   description = "The path to the SSH public key file"
#   type        = string
# }

# variable "additional_storage_size_in_gbs" {
# description = "The size of the additional storage volume in GBs"
# type = number
# default = 54 // 54 GB + 46 GB boot volume = 100 GB total for free tier
# }

variable "state_bucket_name" {
  description = "Name of the bucket to store Terraform state"
  type        = string
  default     = "terraform-state-bucket"
}
