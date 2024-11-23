# Compute instance in Oracle Cloud Infrastructure (OCI)

Executing the Terraform you will get an OCI Compute Instance that could be used as a remote working station.

## Features, installed, configured tools

- `ssh` to be able to connect to the instance
- `Git` (with the given ssh key, and user settings)
- `nvm`
- etc.

Look into the `cloud_init` and `user_init` scripts for further information, modification of the preinstalled tools.

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

- Generate a `PEM` file locally
- Upload the `PEM` file to the OCI console as an API signing key for the previously created user.
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
- We will set the path of the public key as `tfvar`

```bash
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
- The bucket is created automatically when you run `terraform init` just uncomment the relevant part from the `backend.init.tf` file. This file won't bee needed later so feel free to comment its content out again after the bucket is successfully created and you have the backend configuration.
- PUT the backend output in the `backend.tf` file that is gitignored because of the generated content

## OCI Resource Schedule

It could be wise to create an automation to stop your **Compute Instances** daily.
It could be created with Terraform, but than you need a user with special rights or a root user, because the Schedules could only live in the root compartments (that is the tenancy).
So probably this time we should pick the easier way and create the Schedules manually on the OCI Console.

### Steps

- Create a ResourceSchedule on the OCI Console
  - !!! Note that the time of the Schedule is in `UTC`
- Create a Policy for the schedule to enable it to manipulate compute instances. Something like this.

```bash
Allow any-user to manage instance in compartment id <compartmentid of the compute instances e.q.: ocid1.compartment.oc1.....> where all{request.principal.type='resourceschedule'}
```

Look the Links below for further information and possible solutions.

## Links

- [Welcome to the Cloud Foundation - Oracle Cloud basics](https://docs.oracle.com/en/cloud/foundation/cloud_architecture/governance/index.html#introduction)
- [Configure the OCI CLI](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/cliconfigure.htm)
- [Connecting to a Compute Instance](https://docs.oracle.com/en-us/iaas/Content/Compute/Tasks/connect-to-linux-instance.htm#top)
- [OCI Object Storage Backend for Terraform state](https://docs.oracle.com/en-us/iaas/Content/terraform/object-storage-state.htm#s3)
- [OCI Naming Convention](https://docs.oracle.com/en/cloud/foundation/cloud_architecture/governance/naming.html#compartments---naming-convention)
- [Referencing Availability Domains](https://docs.oracle.com/en-us/iaas/Content/terraform/ref-availability-domains.htm)
- [Always Free Resources](https://docs.oracle.com/en-us/iaas/Content/FreeTier/freetier_topic-Always_Free_Resources.htm)
- [How to Upgrade Terraform to a Specific Version Using tfenv](https://www.terraformpilot.com/articles/upgrading-terraform-to-a-specific-version/)
- [Supported Terraform Versions](https://docs.oracle.com/en-us/iaas/Content/ResourceManager/Reference/terraformversions.htm)
- [OCI - supported values for Compute instance and other resources](https://docs.oracle.com/en-us/iaas/tools/python/2.138.1/api/core/models/oci.core.models.Instance.html?highlight=core%20instance#oci.core.models.Instance.shape)
- [OCI - Getting Started with Resource Scheduler](https://docs.oracle.com/en-us/iaas/Content/resource-scheduler/tasks/getting-started_resource_scheduler.htm)
- [OCI - Resource Scheduler Example Policies](https://docs.oracle.com/en-us/iaas/Content/resource-scheduler/references/example_policies.htm)
- [Terraform to create multiple Resource Schedule in Oracle Cloud](https://karthicin.medium.com/terraform-to-create-multiple-resource-schedule-in-oracle-cloud-03aaba51b909)
- [Mastering Oracle Cloud Infrastructure with Terraform: A Comprehensive Guide](https://medium.com/@williamwarley/mastering-oracle-cloud-infrastructure-with-terraform-a-comprehensive-guide-2008d7a8a8e2)
