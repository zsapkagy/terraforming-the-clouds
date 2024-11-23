#!/bin/bash

# init script executed as the ec2-user

set -euo pipefail

cd "$HOME"

aws configure set aws_access_key_id ${var.AWS_CLI_access_key}
aws configure set aws_secret_access_key ${var.AWS_CLI_secret_key}
aws configure set default.region ${var.AWS_CLI_region}


# GIT
# check connection ssh -T git@github.com
# nem lehet tul nagy joga a git keyeknek
chmod 0600 id_ed25519*

# ADD SSH KEY TO THE TRUS
# Add your SSH private key to the ssh-agent TO revent the passhprease question
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

###############
# Configure GIT
###############
# TODO Be able to use variables like in the other cloud solutions
git config --global user.email "${git_user_email}"
git config --global user.name "${git_user_name}"
