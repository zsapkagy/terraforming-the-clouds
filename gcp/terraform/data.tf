#############################################################
# Data sources to get rendered template files, etc
#############################################################


data "template_file" "instance_startup_script" {
  template = file("${path.module}/init/cloud-init.yaml")

  vars = {
    init_script = templatefile("${path.module}/init/init.sh", {
      user = var.user
    })
    user_init_script = templatefile("${path.module}/init/user-init.sh", {
      git_user_name  = var.git_user_name
      git_user_email = var.git_user_email
    })
    github_ssh_key = file(var.ssh_github_privatekey_path)
  }
}

