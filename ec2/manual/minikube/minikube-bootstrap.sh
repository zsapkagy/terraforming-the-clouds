#!/bin/bash

tput setaf 3
echo ''
echo 'Install Kubectl...'
echo '=============================='
tput sgr0

curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
kubectl version --client
tput setaf 3
echo 'DONE.'
echo ''

echo 'Install docker...'
echo '=============================='
tput sgr0
sudo apt-get update -y &&  sudo apt-get install -y docker.io
sudo docker version
tput setaf 3
echo 'DONE.'
echo ''

echo 'Install Minikube...'
echo '=============================='
tput sgr0
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
&& chmod +x minikube \
&& sudo mv minikube /usr/local/bin/
minikube version
# sudo -i
# apt install conntrack
# tput setaf 3
# echo 'DONE.'
# echo ''

# echo 'Starting Minikube...'
# tput sgr0
# minikube start --driver=none
# minikube status