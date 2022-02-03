#!/bin/bash

# init script executed as the final user

set -euo pipefail

cd "$HOME"
UPLOADED_GITHUB_SSH_KEY=~/init/github_ssh_key
GITHUB_SSH_KEY=~/.ssh/github_ssh_key

# GIT
git config --global user.email "${git_user_email}"
git config --global user.name "${git_user_name}"

# Relocate the ssh key
mv $UPLOADED_GITHUB_SSH_KEY ~/.ssh
# Set the correct permissions to the key file
chmod 0600 $GITHUB_SSH_KEY
# Add your SSH private key to the ssh-agent
eval "$(ssh-agent -s)"
ssh-add $GITHUB_SSH_KEY

# Create an ssh config file to auto-load the github keys to the ssh-agent
printf "Host *
  AddKeysToAgent yes
  IdentityFile $GITHUB_SSH_KEY
" >> ~/.ssh/config

echo "try executing 'ssh -T git@github.com' to check github permission"