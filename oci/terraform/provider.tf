terraform {
  required_version = ">= 1.5.7"

  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "~> 6.15"
    }
  }
}

# Configure the OCI provider to use the default CLI config file
provider "oci" {
  config_file_profile = "DEFAULT"
}
