module "compute_instance" {
  for_each = var.instances

  source              = "../../modules/compute_instance"
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  project_name        = var.project_name
  compartment_id      = var.compartment_id

  instance_name = each.value.instance_name
  subnet_id     = each.value.subnet_id == null ? module.vcn.subnet_id[var.public_subnet_names[0]] : each.value.subnet_id
  user_data = templatefile("${path.module}/init/${each.value.instance_name}/cloud-init.yaml.tftpl", {
    user = each.value.os_user,
    user_init = templatefile("${path.module}/init/${each.value.instance_name}/user-init.sh.tftpl", {
      git_user_name  = each.value.git_user_name,
      git_user_email = each.value.git_user_email,
    }),
    github_ssh_key = file(each.value.ssh_github_privatekey_path)
  })

  # COMPUTE
  ## Operating System
  os_name    = each.value.os_name
  os_version = each.value.os_version
  os_user    = each.value.os_user

  ## Instance Configuration
  instance_shape              = each.value.instance_shape
  ocpus                       = each.value.ocpus
  memory_in_gbs               = each.value.memory_in_gbs
  boot_volume_size            = each.value.boot_volume_size
  persisted_block_volume_size = each.value.persisted_block_volume_size

  ## SSH Key
  ssh_public_key_path = each.value.ssh_public_key_path
}

output "compute_instance_outputs" {
  value = module.compute_instance
}
