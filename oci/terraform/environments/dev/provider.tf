terraform {
  required_version = "1.5.7" # latest OCI supported TF version (link in readme to look for latest)

  required_providers {
    oci = {
      source  = "oracle/oci"
      version = ">= 6.18.0"
    }
  }
}

# Configure the OCI provider to use the default CLI config file
provider "oci" {
  config_file_profile = "DEFAULT"
}
