#!/bin/bash

# init script executed as the final user

set -euo pipefail

cd "$HOME"

# GIT
# check connection
ssh -T git@github.com -y
# nem lehet tul nagy joga a git keyeknek
# chmod 0600 id_ed25519*

# ADD SSH KEY TO THE TRUS
# Add your SSH private key to the ssh-agent TO revent the passhprease question
# eval "$(ssh-agent -s)"
# ssh-add ~/.ssh/id_ed25519

git config --global user.email "${git_user_email}"
git config --global user.name "${git_user_name}"