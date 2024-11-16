# Compute instance in Oracle Cloud Infrastructure (OCI)

Executing the Terraform you will get an OCI Compute Instance ready t

## Features, installed, configured tools

- `Git` (with the given ssh key, and user settings)
- `nvm`

Look into the `cloud_init` and `user_init` scripts for further information, modification of the tools.

## Prerequisites

- Oracle Cloud Infrastructure account
- Oracle Cloud Infrastructure CLI
- Terraform CLI (check supported version)

## Before you begin

### IMPORTANT

- Be on the right OCI account!
- DO NOT create instances on a WRONG account!
- Check what is the supported Terraform version by OCI to prevent nasty problems like (s3 bucket access problem, etc.)

### Use the correct Terraform version

Check the [OCI-Supported Terraform Versions](https://docs.oracle.com/en-us/iaas/Content/ResourceManager/Reference/terraformversions.htm) documentation what is the latest currently supported Terraform version.
Check the `.terraform-version` and update if required.
Use `tfenv install` where the `.terraform-version` is to install the correct TF version.

### Set up OCI CLI

You have 2 options to configure the OCI CLI.
Either way, you need to create RSA keys. But this could be done during the OCI CLI setup or before.

#### Create a user

Create a user in the OCI console in the compartment where you want to create the resources
(Do NOT use the root compartment and the root user for security reasons!)

#### Create RSA keys for the user

See [OCI Set Up OCI-Terraform](https://docs.oracle.com/en-us/iaas/developer-tutorials/tutorials/tf-provider/01-summary.htm)

You create RSA keys to let Terraform signing in to your Oracle Cloud Infrastructure account.

- Generate a PEM file locally
- Upload the PEM file to the OCI console as an API signing key for the previously created user.
- Use this key during the OCI CLI configuration

#### Create OCI Configuration

- **PREFERRED** - Configure the OCI CLI with a configuration file (using an optional profile)
  For this see [Setting up the OCI CLI Configuration File](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/cliinstall.htm#configfile)
  This is the preferred way because the `OCI CLI` would be helpful for example turn ON/OFF the Compute instance, etc.
  And the Terraform could use this too.

  Execute the `oci setup config` command to start the configuration

- Configure the OCI CLI with the Terraform Provider configuration
  For this see [OCI Getting Started with Terraform Provider](https://docs.oracle.com/en-us/iaas/Content/terraform/getting-started.htm)

### Create a compartment on the OCI console

See [OCI Compartment Structure](https://docs.oracle.com/en/cloud/foundation/cloud_architecture/governance/compartments.html#example-compartment-structure) for more info about compartments.

Note the OCID of the compartment, we will use this later.

### Create an ssh key pair to be used for connecting to the Compute instance

See [OCI Create SSH Key Pair](https://docs.oracle.com/en-us/iaas/developer-tutorials/tutorials/tf-compute/01-summary.htm#prepare)

You can create a ssh key pair in the OCI console or locally and upload the public key to the OCI console.

### Create an SSH key pair to let the instance access Github

The instance will use this `ssh` key to access the github with it.

If you don't already have an `ssh` key to use with this instance create a new one

- [Connecting to GitHub with SSH](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/about-ssh)
- Set the path of the public key as `tfvar`

```
mkdir ~/.ssh/<USER_NAME>
ssh-keygen -t ed25519 -f ~/.ssh/<USER_NAME>/<USER_NAME>_oci_ci_github_key -C "<YOUR_EMAIL>@gmail.com"
```

### Create/Update the `terraform.tfvars` file

- Update the `compartment_id` with the OCID of the compartment where you want to create the resources
- Update the `region` with the region where you want to create the resources
- Update the `ssh_public_key_path` with the path of the ssh public key file for accessing the Compute Instance
- Update the `ssh_github_privatekey_path` with the path of the private SSH Key, `git_user_name` and `gith_user_email` for accessing Github

## Terraform State

- Terraform state is stored in a bucket in the OCI console
- The bucket name is configured in the `terraform.tfvars` file
- The bucket is created automatically when you run `terraform init`

## Links

- [Configure the OCI CLI](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/cliconfigure.htm)
- [Connecting to a Compute Instance](https://docs.oracle.com/en-us/iaas/Content/Compute/Tasks/connect-to-linux-instance.htm#top)
- [OCI Object Storage Backend for Terraform state](https://docs.oracle.com/en-us/iaas/Content/terraform/object-storage-state.htm#s3)
- [OCI Naming Convention](https://docs.oracle.com/en/cloud/foundation/cloud_architecture/governance/naming.html#compartments---naming-convention)
- [Referencing Availability Domains](https://docs.oracle.com/en-us/iaas/Content/terraform/ref-availability-domains.htm)
- [Always Free Resources](https://docs.oracle.com/en-us/iaas/Content/FreeTier/freetier_topic-Always_Free_Resources.htm)
- [How to Upgrade Terraform to a Specific Version Using tfenv](https://www.terraformpilot.com/articles/upgrading-terraform-to-a-specific-version/)
- [Supported Terraform Versions](https://docs.oracle.com/en-us/iaas/Content/ResourceManager/Reference/terraformversions.htm)
