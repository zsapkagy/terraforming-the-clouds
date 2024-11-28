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

output "ssh_config" {
  description = "SSH config"
  value       = <<EOF
Host OCI_${var.instance_name}
  HostName ${oci_core_instance.this.public_ip}
  PreferredAuthentications publickey
  IdentityFile ${replace(var.ssh_public_key_path, ".pub", "")}
  IdentitiesOnly yes
  User ${var.os_user}
EOF
}

output "bashrc_or_zshrc" {
  description = "Bash or Zsh configuration"
  value       = <<EOF
#########
# OCI WORKSTATION: ${var.instance_name}
#########
OCI_WORKSTATION_IP_${var.instance_name}="${oci_core_instance.this.public_ip}"
OCI_WORKSTATION_INSTANCE_ID_${var.instance_name}="${oci_core_instance.this.id}"
alias oci.${var.instance_name}.connect="ssh -i ${replace(var.ssh_public_key_path, ".pub", "")} ${var.os_user}@$OCI_WORKSTATION_IP_${var.instance_name}"
alias oci.${var.instance_name}.run="oci compute instance action --action START --instance-id $OCI_WORKSTATION_INSTANCE_ID_${var.instance_name}"
alias oci.${var.instance_name}.stop="oci compute instance action --action SOFTSTOP --instance-id $OCI_WORKSTATION_INSTANCE_ID_${var.instance_name}"
EOF
}
