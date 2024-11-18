# Terraforming the clouds

This repo contains some WorkInProgress code and scripts that could help create resources in various cloud providers.

## Content

### [AWS](./aws/README.md) - Out of date

- **EC2 instance** with
  - preinstalled tools

### [GOOGLE - GCP](./gcp/README.md)

- **Compute instance** with
  - preinstalled tools (docker, nvm, helm, kubernetes, scaffold, minikube, Go, etc)
  - preconfigured ssh to access the instance
  - preconfigured GitHub access with ssh

### [ORACLE - OCI](./oci/README.md)

- **VCN**
- Multiple **Compute instance** with
  - various AlwaysFree shapes
  - preinstalled tools (docker, nvm, etc)
  - preconfigured ssh to access the instance
  - preconfigured GitHub access with ssh
- Terraform **State stored in OCI S3 Bucket**

## Links

Usefull tutorials, docs

### Security

- [Protect Sensitive Input Variables](https://learn.hashicorp.com/tutorials/terraform/sensitive-variables)
- [A comprehensive guide to managing secrets in your Terraform code](https://blog.gruntwork.io/a-comprehensive-guide-to-managing-secrets-in-your-terraform-code-1d586955ace1)

### Etc

- [Install and configure Minikube](https://minikube.sigs.k8s.io/docs/start/)
- [Connecting to GitHub with SSH](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/about-ssh)
- [Terraform examples for all the clouds](https://github.com/brokedba/terraform-examples)
