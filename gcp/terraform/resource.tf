resource "google_service_account" "default" {
  account_id   = "sa-${var.instance_name}"
  display_name = "Workstation Service Account"
}

resource "google_compute_address" "static-external-ip-address" {
  name = "static-external-ip-address-${var.instance_name}"
}
# resource "google_compute_network" "vpc_network" {
#   name                    = "terraform-network-for-workstation-instances"
#   auto_create_subnetworks = "true"
# }

resource "google_compute_instance" "default" {
  name         = var.instance_name
  machine_type = var.machine_type

  tags = ["dev", "hlf", "workstation"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
      size  = var.disk_size_gb
    }
  }

  // Local SSD disk
  #   scratch_disk {
  #     interface = "SCSI"
  #   }

  network_interface {
    # A default network is created for all GCP projects
    # network = google_compute_network.vpc_network.self_link
    network = "default"

    access_config {
      // Static public IP
      nat_ip = google_compute_address.static-external-ip-address.address
    }
  }

  metadata = {
    ssh-keys = "${var.user}:${file(var.ssh_publickey_path)}"
    user-data = templatefile("${path.module}/init/cloud-init.yaml.tftpl", {
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
    })
  }

  metadata_startup_script = "/home/${var.user}/init/startup.sh"

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }

  allow_stopping_for_update = true
}
