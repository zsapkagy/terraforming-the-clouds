output "self_link" {
  description = "Self-link of instance template"
  value       = google_compute_instance.default.self_link
}

output "instance_name" {
  description = "Name of instance template"
  value       = google_compute_instance.default.name
}

# output "external_ip" {
#   description = "The external IP address of the instance"
#   value       = google_compute_instance.default.network_interface.0.access_config.0.nat_ip
# }

# output "SSH_Connection" {
#   description = "Command to ssh into the instance"
#   value       = format("ssh -i ${var.ssh_privatekey_path} ${var.user}@%s", google_compute_instance.default.network_interface.0.access_config.0.nat_ip)
# }

output "gcloud_config" {
  description = "Set gcloud compute zone config"
  value       = "gcloud config set compute/zone ${var.zone}"
}

output "gcloud_status" {
  description = "Get gcloud compute instance status"
  value       = "gcloud compute instances describe ${var.instance_name} --format='yaml(name,status)'"
}

output "gcloud_start" {
  description = "Start gcloud compute instance"
  value       = "gcloud compute instances start ${var.instance_name}"
}

output "gcloud_stop" {
  description = "Stop gcloud compute instance"
  value       = "gcloud compute instances stop ${var.instance_name}"
}
