# output "availability_domains" {
#   description = "The list of availability domains in the region"
#   value       = data.oci_identity_availability_domains.ads.availability_domains[*].name
# }

output "vcn_id" {
  description = "OCID of created VCN"
  value       = module.vcn.vcn_id
}

output "instance_public_ip" {
  description = "Public IP of the instance"
  value       = oci_core_instance.free_tier_instance.public_ip
}

output "ssh_connection_string" {
  description = "SSH connection command"
  value       = "ssh -i ${replace(var.ssh_public_key_path, ".pub", "")} ${var.os_user}@${oci_core_instance.free_tier_instance.public_ip}"
}

output "instance_id" {
  description = "OCID of the compute instance"
  value       = oci_core_instance.free_tier_instance.id
}

output "start_script" {
  description = "Script to start the instance"
  value       = "oci compute instance action --action START --instance-id ${oci_core_instance.free_tier_instance.id}"
}

output "stop_script" {
  description = "Script to stop the instance"
  value       = "oci compute instance action --action SOFTSTOP --instance-id ${oci_core_instance.free_tier_instance.id}"
}
