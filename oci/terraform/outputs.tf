output "availability_domains" {
  description = "The list of availability domains in the region"
  value       = data.oci_identity_availability_domains.ads.availability_domains[*].name
}

output "vcn_id" {
  description = "OCID of created VCN"
  value       = module.vcn.vcn_id
}

output "public_subnet_id" {
  description = "OCID of the public subnet"
  value       = module.subnet.subnet_id
}

output "public_subnet_cidr" {
  description = "CIDR block of the public subnet"
  value       = module.vcn.subnet_id
}

output "internet_gateway_id" {
  description = "OCID of internet gateway"
  value       = module.vcn.internet_gateway_id
}
