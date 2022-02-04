#############################################################
# Data sources to get rendered template files, etc
#############################################################


data "template_file" "instance_startup_script" {
  template = file("${path.module}/init/cloud-init.yaml.tftpl")

  vars = {
    startup = templatefile("${path.module}/init/startup.sh.tftpl", {
    })
    init = templatefile("${path.module}/init/init.sh.tftpl", {
      user = var.user
    })
    user_init = templatefile("${path.module}/init/user-init.sh.tftpl", {
      git_user_name  = var.git_user_name
      git_user_email = var.git_user_email
    })
    github_ssh_key = file(var.ssh_github_privatekey_path)
  }
}

