# Goggle cloud Compute instances

Init scripts and info how to acces the instances

# IMPORTANT

Be on the right GCP account!
DO NOT CREATE instances on a WRONG account!

# Before you begin

## Set up GCP

- Create a project
- Enable billing on the project
- Enable Compute Engine API
  for more details see [link](https://learn.hashicorp.com/tutorials/terraform/google-cloud-platform-build?in=terraform/gcp-get-started#set-up-gcp)

## Initialize the `gcloud` SDK

Execute the `gcloud init` command

If you dont have `gcloud` installed, use the [official guide](https://cloud.google.com/sdk/docs/install#installation_instructions)

## Configure the GCP Provider

To configure the provider execute the following command

```
gcloud auth application-default login
```

for more details see [link](https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/getting_started#configuring-the-provider)

- Run `terraform plan` to check the previous configurations

## Create an SSH key pair to access the instance

This ssh key will be used to access the instance.

If you don't already have an `ssh` key to use with this instance create a new one

- [Create an SSH key pair](https://cloud.google.com/compute/docs/connect/create-ssh-keys)
- Set the path of the public key as `tfvar`

```
mkdir ~/.ssh/<USER_NAME>
ssh-keygen -t rsa -f ~/.ssh/<USER_NAME>/<USER_NAME>_gci_access_key -C <USER_NAME> -b 2048
```

## Create an SSH key pair to let the instance access Github

The instance will use this ssh key to access the github with it.

If you don't already have an `ssh` key to use with this instance create a new one

- [Connecting to GitHub with SSH](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/about-ssh)
- Set the path of the public key as `tfvar`

```
mkdir ~/.ssh/<USER_NAME>
ssh-keygen -t ed25519 -f ~/.ssh/<USER_NAME>/<USER_NAME>_gci_github_key -C "<USER_NAME>@example.com"
```

# Terraform Variables

The available variables can be seen in the `terraform/variable.tf` file. There are some with default values.

All the possible variables could be defined in the a `terraform/terraform.tfvars` file.

# Terraforming

Execute `terraform plan` and or `terraform apply` to check and deploy the terraform plan.

# Links

Usefull tutorials, docs

- [Getting Started with the Google Provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/getting_started#configuring-the-provider)
- [GCP with terraform tutorial](https://cloud.google.com/community/tutorials/getting-started-on-gcp-with-terraform)
- [Reserving a static external IP address ](https://cloud.google.com/compute/docs/ip-addresses/reserve-static-external-ip-address)
