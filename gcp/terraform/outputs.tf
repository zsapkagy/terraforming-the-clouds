output "self_link" {
  description = "Self-link of instance template"
  value       = google_compute_instance.default.self_link
}

output "name" {
  description = "Name of instance template"
  value       = google_compute_instance.default.name
}

output "external_ip" {
  description = "The external IP address of the instance"
  value       = google_compute_instance.default.network_interface.0.access_config.0.nat_ip
}
