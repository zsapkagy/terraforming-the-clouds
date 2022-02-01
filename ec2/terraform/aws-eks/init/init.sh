#!/bin/bash

# System init script executed as the root user

set -euo pipefail

# Grant default user docker access
# usermod -a -G docker "${user}"
usermod -a -G docker ec2-user
#start docker
systemctl start docker.service

# Start user level initialization in tmux
# runuser -u "${user}" -- bash -s <<'EOF'
runuser -u ec2-user -- bash -s <<'EOF'
set -euo pipefail
cd "$HOME"
tmux new-session -d -n init; sleep 1
tmux send-keys -l -t init $'user.init.sh\n'
EOF