module "vcn" {
  source  = "oracle-terraform-modules/vcn/oci"
  version = "3.6.0"

  # Required Inputs
  compartment_id = var.compartment_id
  region         = var.region

  # VCN Configuration
  vcn_name      = var.vcn_name
  vcn_dns_label = var.vcn_dns_label
  vcn_cidrs     = var.vcn_cidrs

  # Gateway Configuration
  create_internet_gateway  = true
  create_nat_gateway       = false
  create_service_gateway   = false
  lockdown_default_seclist = false # Do NOT clear the ingress and egress configs

  freeform_tags = {
    "Project"     = var.project_name
    "Environment" = var.environment
    "Managed_by"  = "Terraform"
  }

  subnets = {
    public_subnet = {
      name              = var.public_subnet_names[0]
      cidr_block        = var.public_subnet_cidrs[0]
      dns_label         = "public"
      is_public         = true
      route_table_id    = module.vcn.ig_route_id
      security_list_ids = [module.vcn.default_security_list_id] # Reference the default security list
    }
  }
}