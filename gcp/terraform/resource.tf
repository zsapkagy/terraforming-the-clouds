resource "google_service_account" "default" {
  account_id   = "service-account-id"
  display_name = "Service Account"
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
      // Ephemeral public IP
    }
  }

  metadata = {
    ssh-keys  = "${var.user}:${file(var.ssh_publickey_path)}"
    user-data = data.template_file.instance_startup_script.rendered
  }

  metadata_startup_script = "/etc/skel/init/init.sh"

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }

  allow_stopping_for_update = true

  # depends_on = [data.template_file.instance_startup_script]
}
