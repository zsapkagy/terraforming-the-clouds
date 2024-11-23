# EC2 Instance for Kubernetes in AWS EKS - OUTDATED

This Terraform configuration creates an EC2 instance optimized for working with Kubernetes in AWS EKS.

## Instance Details

- AMI: Amazon Linux
- Includes: tmux, Git, Kubectl, Helm, Terraform, AWS CLI

## Prerequisites

Required environment variable:

- `TF_VAR_AWS_KEY_PAIR_PUBLIC_KEY_FILE_PATH`

## Resources Created

- Security Group
- EC2 instance

## Features

Preconfigured with essential tools for Kubernetes development

- Helm installation - in case the cloud_init solution is not working (fallback: https://helm.sh/docs/intro/install/#from-script)
- Configured AWS CLI
- Configured kubectl
- Terraform

## TODO

1. Automate AWS CLI configuration
2. Automate Git SSH key setup and configuration (see: ec2/terraform/aws-eks/init/user-init.sh)
   - Copy SSH key to instance
   - Configure global Git settings (user.name, user.email)
   - Add Git SSH key to agent with passphrase (see: https://linuxkamarada.com/en/2019/07/14/using-git-with-ssh-keys/#.Ya4mKvGZNQJ)
     - `eval "$(ssh-agent -s)"`
     - `ssh-add ~/.ssh/github/for-ec2/id_ed25519`
3. Configure Docker service to start automatically on instance boot
   ```
   sudo systemctl enable docker.service
   ```
4. Add SSH identity permanently to the agent

```
# put this in your ~/.bashrc

eval $(ssh-agent)
ssh-add ~/.ssh/where_every_privake_key_is
```

5. Install Node.js and npm (preferably using nvm) (https://docs.aws.amazon.com/sdk-for-javascript/v2/developer-guide/setting-up-node-on-ec2-instance.html)
6. Install Docker Compose
   - https://docs.docker.com/compose/install/
   - Add command-line completion: https://docs.docker.com/compose/completion/
7. Install ShellCheck for shell script best practices
8. Install kubectl
9. Configure access to the cluster
   ```
   aws eks --region eu-west-1 update-kubeconfig --name [cluster-name]
   ```

## Automatically Load SSH Agent and GitHub SSH Key During Login

Add the following to `.bash_profile`:

```

SSH_ENV="$HOME/.ssh/agent-environment"
PATH_TO_GITHUB_SSH="$HOME/.ssh/github/for-ec2/id_ed25519_02"

function start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add "$PATH_TO_GITHUB_SSH"
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    #ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi
```
