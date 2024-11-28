resource "oci_core_instance" "this" {
  availability_domain = var.availability_domain
  compartment_id      = var.compartment_id
  display_name        = var.instance_name
  shape               = var.instance_shape

  shape_config {
    ocpus         = var.ocpus
    memory_in_gbs = var.memory_in_gbs
  }

  create_vnic_details {
    subnet_id        = var.subnet_id
    assign_public_ip = true
  }

  source_details {
    source_type             = "image"
    source_id               = data.oci_core_images.os_image.images[0].id
    boot_volume_size_in_gbs = var.boot_volume_size
  }

  metadata = {
    ssh_authorized_keys = file(var.ssh_public_key_path)
    user_data           = base64encode(var.user_data)
  }

  freeform_tags = {
    "Project"     = var.project_name
    "Environment" = var.environment
    "Managed_by"  = "Terraform"
    "OS"          = var.os_name
    "Version"     = var.os_version
  }
}

resource "oci_core_volume" "persisted_block_volume" {
  count               = var.persisted_block_volume_size != null ? 1 : 0
  availability_domain = var.availability_domain
  compartment_id      = var.compartment_id
  display_name        = "${var.instance_name}-persisted-volume"
  size_in_gbs         = var.persisted_block_volume_size

  freeform_tags = {
    "Project"     = var.project_name
    "Environment" = var.environment
    "Managed_by"  = "Terraform"
    "Purpose"     = "Persisted Data"
  }
}

resource "oci_core_volume_attachment" "persisted_block_volume_attachment" {
  count           = var.persisted_block_volume_size != null ? 1 : 0
  attachment_type = "paravirtualized"
  instance_id     = oci_core_instance.this.id
  volume_id       = oci_core_volume.persisted_block_volume[0].id
  device          = "/dev/oracleoci/oraclevdb"
}
