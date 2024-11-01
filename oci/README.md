# Oracle Cloud Infrastructure (OCI)

## Prerequisites

- Oracle Cloud Infrastructure account
- Oracle Cloud Infrastructure CLI
- Terraform CLI

## Before you begin

### Set up OCI CLI

#### IMPORTANT

- Be on the right OCI account!
- DO NOT create instances on a WRONG account!

You have 2 options to configure the OCI CLI:

- Configure the OCI CLI with a configuration file (using an optional profile)
  For this see [OCI CLI Setup Guide from Terraform](https://developer.hashicorp.com/terraform/tutorials/oci-get-started/oci-build)
- Configure the OCI CLI with the Terraform Provider configuration
  For this see [OCI Getting Started with Terraform Provider](https://docs.oracle.com/en-us/iaas/Content/terraform/getting-started.htm)

Either way, you need to create RSA keys. But this could be done during the OCI CLI setup or before.

#### Create a user

Create a user in the OCI console in the compartment where you want to create the resources
(Do NOT use the root compartment and the root user for security reasons!)

#### Create RSA keys

See [OCI Set Up OCI-Terraform](https://docs.oracle.com/en-us/iaas/developer-tutorials/tutorials/tf-provider/01-summary.htm)

You create RSA keys for API signing in to your Oracle Cloud Infrastructure account.

- Generate a PEM file locally
- Upload the PEM file to the OCI console as an API signing key for the previously created user
- Use the path of the PEM file in the `terraform.tfvars` file as the `private_key_path`

### Create/Update the `terraform.tfvars` file

- Update the `private_key_path` with the path of the private RSA PEM file
- Update the `compartment_id` with the OCID of the compartment where you want to create the resources
- Update the `region` with the region where you want to create the resources
- Update the `tenancy_ocid`, `user_ocid`, and `fingerprint` with the values from the OCI console

## Terraform State

- Terraform state is stored in a bucket in the OCI console
- The bucket name is configured in the `terraform.tfvars` file
- The bucket is created automatically when you run `terraform init`

# Links

- [OCI Object Storage Backend for Terraform state](https://docs.oracle.com/en-us/iaas/Content/terraform/object-storage-state.htm#s3)
- [OCI Naming Convention](https://docs.oracle.com/en/cloud/foundation/cloud_architecture/governance/naming.html#compartments---naming-convention)
- [Referencing Availability Domains](https://docs.oracle.com/en-us/iaas/Content/terraform/ref-availability-domains.htm)
