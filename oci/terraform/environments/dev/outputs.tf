output "vcn_id" {
  description = "OCID of created VCN"
  value       = module.vcn.vcn_id
}
output "availability_domains" {
  description = "List of availability domains in the specified compartment"
  value       = data.oci_identity_availability_domains.ads.availability_domains[*].name
}
