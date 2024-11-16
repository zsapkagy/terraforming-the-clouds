locals {
  ci-hlf = {
    os_user       = "ubuntu" // ubuntu, opc
    os_name       = "Canonical Ubuntu"
    os_version    = "24.04"
    instance_name = "ci-hlf"
    # instance_shape = "VM.Standard.A1.Flex" # Free tier shape
    # ocpus          = 2                     # Maximum for free tier for this shape
    # memory_in_gbs  = 24                    # Maximum for free tier for this shape
    instance_shape = "VM.Standard.E2.1.Micro" # Free tier shape
    ocpus          = 1                        # Maximum for free tier for this shape
    memory_in_gbs  = 1                        # Maximum for free tier for this shape

    # User
    ssh_public_key_path        = var.ssh_public_key_path
    ssh_github_privatekey_path = var.ssh_github_privatekey_path
    git_user_name              = var.git_user_name
    git_user_email             = var.git_user_email // Assuming this is passed as a variable
    project_name               = "LearningHLF"

  }
  # OS
}

module "compute_instance_hlf" {
  source              = "../../modules/compute_instance"
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  project_name        = local.ci-hlf.project_name

  compartment_id = var.compartment_id

  instance_name = local.ci-hlf.instance_name
  subnet_id     = module.vcn.subnet_id[var.public_subnet_names[0]]
  user_data = templatefile("${path.module}/${local.ci-hlf.instance_name}/init/cloud-init.yaml.tftpl", {
    user = local.ci-hlf.os_user,
    user_init = templatefile("${path.module}/${local.ci-hlf.instance_name}/init/user-init.sh.tftpl", {
      git_user_name  = local.ci-hlf.git_user_name,
      git_user_email = local.ci-hlf.git_user_email,
    }),
    github_ssh_key = file(local.ci-hlf.ssh_github_privatekey_path)
  })

  # COMPUTE
  ## Operating System
  os_name    = local.ci-hlf.os_name
  os_version = local.ci-hlf.os_version
  os_user    = local.ci-hlf.os_user

  ## Instance Configuration
  instance_shape = local.ci-hlf.instance_shape
  ocpus          = local.ci-hlf.ocpus
  memory_in_gbs  = local.ci-hlf.memory_in_gbs

  ## SSH Key
  ssh_public_key_path        = local.ci-hlf.ssh_public_key_path
  ssh_github_privatekey_path = local.ci-hlf.ssh_github_privatekey_path
  git_user_name              = local.ci-hlf.git_user_name
  git_user_email             = local.ci-hlf.git_user_email
}

output "hlf_instance_outputs" {
  value = module.compute_instance_hlf
}
