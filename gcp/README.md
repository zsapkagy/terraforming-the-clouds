# Goggle cloud Compute instances
Init scripts and info how to acces the instances

## Before you begin

### Set up GCP
* Create a project
* Enable billing on the project
* Enable Compute Engine API
for more details see [link](https://learn.hashicorp.com/tutorials/terraform/google-cloud-platform-build?in=terraform/gcp-get-started#set-up-gcp)


### Initialize the `gcloud` SDK

Execute the `gcloud init` command

If you dont have `gcloud` installed, use the [official guide](https://cloud.google.com/sdk/docs/install#installation_instructions)

### Configure the GCP Provider
To configure the provider execute the following command
```
gcloud auth application-default login
```
for more details see [link](https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/getting_started#configuring-the-provider)

* Run `terraform plan` to check the previous configurations

### Create an SSH key pair

If you don't already have an `ssh` key to use with this instance create a new one
* [Create an SSH key pair](https://cloud.google.com/compute/docs/connect/create-ssh-keys)
* Set the path of the public key as `tfvar`

## Links
Usefull tutorials, docs

* [Getting Started with the Google Provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/getting_started#configuring-the-provider)
* [GCP with terraform tutorial](https://cloud.google.com/community/tutorials/getting-started-on-gcp-with-terraform)
* [Protect Sensitive Input Variables](https://learn.hashicorp.com/tutorials/terraform/sensitive-variables)