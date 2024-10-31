resource "oci_objectstorage_bucket" "terraform_state" {
  compartment_id = var.compartment_id
  name           = var.state_bucket_name
  namespace      = data.oci_objectstorage_namespace.ns.namespace
  access_type    = "NoPublicAccess"
  versioning     = "Enabled"
}

data "oci_objectstorage_namespace" "ns" {
  compartment_id = var.compartment_id
}