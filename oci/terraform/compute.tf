# Get the latest OS image
data "oci_core_images" "os_image" {
  compartment_id           = var.compartment_id
  operating_system         = var.os_name
  operating_system_version = var.os_version
  shape                    = var.instance_shape
  sort_by                  = "TIMECREATED"
  sort_order               = "DESC"
}

resource "oci_core_instance" "free_tier_instance" {
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = var.compartment_id
  display_name        = "free-tier-${lower(split(" ", var.os_name)[1])}"
  shape               = var.instance_shape

  shape_config {
    ocpus         = var.ocpus
    memory_in_gbs = var.memory_in_gbs
  }

  create_vnic_details {
    subnet_id        = module.vcn.subnet_id[var.public_subnet_names[0]]
    assign_public_ip = true
  }

  source_details {
    source_type = "image"
    source_id   = data.oci_core_images.os_image.images[0].id
  }

  metadata = {
    ssh_authorized_keys = file(var.ssh_public_key_path)
    user_data           = base64encode(templatefile("${path.module}/init/cloud-init.yaml.tftpl", {
    user = var.os_user,
      user_init = templatefile("${path.module}/init/user-init.sh.tftpl", {
        git_user_name  = var.git_user_name
        git_user_email = var.git_user_email
      })
      github_ssh_key = file(var.ssh_github_privatekey_path)
    }))
  }

  freeform_tags = {
    "Project"     = var.project_name
    "Environment" = var.environment
    "Managed_by"  = "Terraform"
    "OS"          = var.os_name
    "Version"     = var.os_version
  }
}

# resource "oci_core_volume" "additional_storage" {
#   availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
#   compartment_id      = var.compartment_id
#   display_name        = "AdditionalStorage"
#   size_in_gbs         = var.additional_storage_size_in_gbs
# }

# resource "oci_core_volume_attachment" "additional_storage_attachment" {
#   attachment_type = "paravirtualized"
#   instance_id     = oci_core_instance.free_tier_instance.id
#   volume_id       = oci_core_volume.additional_storage.id
# }
