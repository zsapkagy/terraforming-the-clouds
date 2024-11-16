# # Use local backend initially only during cration of the backend configuration
# terraform {
#   backend "local" {}
# }

# # # # Output the backend config
# # output "backend_config" {
# #   value = <<EOF
# # // Use this as the actual backend coniguration FOR (Terraform version >= 1.6.4)
# # terraform {
# #   backend "s3" {
# #     bucket                      = "${oci_objectstorage_bucket.terraform_state.name}"
# #     key                         = "terraform.tfstate"
# #     region                      = "${var.region}"
# #     shared_credentials_files     = ["~/.aws/credentials"]
# #     skip_region_validation      = true
# #     skip_credentials_validation = true
# #     skip_requesting_account_id  = true
# #     use_path_style              = true
# #     skip_s3_checksum            = true
# #     skip_metadata_api_check = true
# #     endpoints = {
# #       s3 = "https://${data.oci_objectstorage_namespace.ns.namespace}.compat.objectstorage.${var.region}.oraclecloud.com"
# #     }
# #   }
# # }
# # EOF
# # }

# output "backend_config" {
#   value = <<EOF
# // Use this as the actual backend coniguration FOR (Terraform version <= 1.6.4)
# terraform {
#   backend "s3" {
#     bucket                      = "${oci_objectstorage_bucket.terraform_state.name}"
#     key                         = "terraform.tfstate"
#     region                      = "${var.region}"
#     skip_region_validation      = true
#     skip_credentials_validation = true
#     skip_metadata_api_check     = true
#     force_path_style            = true
#     endpoint                    = "https://${data.oci_objectstorage_namespace.ns.namespace}.compat.objectstorage.${var.region}.oraclecloud.com"
#   }
# }
# EOF
# }

# ##############################
# # REAL backend configuration
# # Note: variables are not supported in backend configuration !!!
# ##############################
# # terraform {
# #   backend "s3" {
# #     bucket = "terraform-state-bucket"
# #     key    = "terraform.tfstate"
# #     region = "eu-frankfurt-1"
# #     endpoints = {
# #       s3 = "https://frgg6ywgbadz.compat.objectstorage.eu-frankfurt-1.oraclecloud.com"
# #     }
# #     # shared_credentials_files    = ["~/.aws/credentials"]
# #     skip_region_validation      = true
# #     skip_credentials_validation = true
# #     skip_requesting_account_id  = true
# #     use_path_style              = true
# #     skip_s3_checksum            = true
# #     skip_metadata_api_check     = true
# #   }
# # }
terraform {
  backend "s3" {
    bucket                      = "terraform-state-bucket"
    key                         = "terraform.tfstate"
    region                      = "eu-frankfurt-1"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    force_path_style            = true
    endpoint                    = "https://frgg6ywgbadz.compat.objectstorage.eu-frankfurt-1.oraclecloud.com"
  }
}
