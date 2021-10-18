#!/bin/bash

tput setaf 3
echo ''
echo 'Extra init steps...'
echo '=============================='
tput sgr0

apt install conntrack
openssl rand -writerand .rnd
tput setaf 3
echo 'DONE.'
echo ''

echo 'Starting Minikube...'
tput sgr0
minikube start --driver=none
minikube status