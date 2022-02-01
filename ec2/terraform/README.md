Creates an ec2 instance to work with Kubernates in AWS EKS

AMI: Amazon linux

Required environment variables
* TF_VAR_AWS_KEY_PAIR_PUBLIC_KEY_FILE_PATH

Creates
* Security Group
* EC2 instance

Contains
* tmux
* Git
* Kubectl
* Helm - in case the cloud_init solution is not working https://helm.sh/docs/intro/install/#from-script
* Terraform
* Configured AWS CLI

TODO:
* automatic AWS configure
* auto GIT ssh copy to the instance and config (see: ec2/terraform/aws-eks/init/user-init.sh)
* add GIT global config (user.name, user.email)
* add git-ssh key to the agent with the passphrase (see: https://linuxkamarada.com/en/2019/07/14/using-git-with-ssh-keys/#.Ya4mKvGZNQJ)
  * $ `eval "$(ssh-agent -s)"`
  * $ `ssh-add ~/.ssh/github/for-ec2/id_ed25519`
* auto start the docker service every time during instance start
```
sudo systemctl start docker.service
```
* add ssh idendity permanently to the agent

```
# put this in your ~/.bashrc

eval $(ssh-agent)
ssh-add ~/.ssh/where_every_privake_key_is 
```

* install npm + node probably with nvm (https://docs.aws.amazon.com/sdk-for-javascript/v2/developer-guide/setting-up-node-on-ec2-instance.html)

* install docker-compose (https://docs.docker.com/compose/install/)
* install docker-compose command-line completion (https://docs.docker.com/compose/completion/)
* add shellcheck to be able to check the shell scripts against best practices like the add " around the variables in the scripts, etc, check shellcheck wiki

* install kubectl
* get config To access the cluster create kubeconfig file with: aws eks --region eu-west-1 update-kubeconfig --name [cluster-name]


## Automatically load SSH agent and github ssh key during login
.bash_profile
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