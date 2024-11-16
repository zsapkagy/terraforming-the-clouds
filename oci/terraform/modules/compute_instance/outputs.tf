output "instance_id" {
  value = oci_core_instance.this.id
}

output "instance_public_ips" {
  value = oci_core_instance.this.public_ip
}

output "ssh_connection_string" {
  description = "SSH connection command"
  value       = "ssh -i ${replace(var.ssh_public_key_path, ".pub", "")} ${var.os_user}@${oci_core_instance.this.public_ip}"
}

output "start_script" {
  description = "Script to start the instance"
  value       = "oci compute instance action --action START --instance-id ${oci_core_instance.this.id}"
}

output "stop_script" {
  description = "Script to stop the instance"
  value       = "oci compute instance action --action SOFTSTOP --instance-id ${oci_core_instance.this.id}"
}
