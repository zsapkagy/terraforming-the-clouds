output "availability_domains" {
  description = "The list of availability domains in the region"
  value       = data.oci_identity_availability_domains.ads.availability_domains[*].name
}
