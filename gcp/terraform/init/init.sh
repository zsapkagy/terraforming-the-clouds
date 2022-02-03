#!/bin/bash

# System init script executed as the root user

set -euo pipefail


# Grant default user docker access
usermod -a -G docker ${user}
#start docker
systemctl start docker.service

# Start user level initialization in tmux

echo "### USER::${user}"
runuser -u ${user} -- bash -s <<'EOF'
set -euo pipefail
cd "$HOME"
tmux new-session -d -n init; sleep 1
tmux send-keys -l -t init $'init/user-init.sh\n'
EOF