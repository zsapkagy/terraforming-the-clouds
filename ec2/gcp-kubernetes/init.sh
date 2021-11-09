#!/bin/bash


tput setaf 3
echo ''
echo 'INIT VPC, Subnet, Firewall...'
echo '=============================='
tput sgr0

gcloud compute networks create kubernetes-the-hard-way --subnet-mode custom

gcloud compute networks subnets create kubernetes \
  --network kubernetes-the-hard-way \
  --range 10.240.0.0/24

gcloud compute firewall-rules create kubernetes-the-hard-way-allow-internal \
  --allow tcp,udp,icmp \
  --network kubernetes-the-hard-way \
  --source-ranges 10.240.0.0/24,10.200.0.0/16

gcloud compute firewall-rules create kubernetes-the-hard-way-allow-external \
  --allow tcp:22,tcp:6443,icmp \
  --network kubernetes-the-hard-way \
  --source-ranges 0.0.0.0/0

gcloud compute addresses create kubernetes-the-hard-way \
  --region $(gcloud config get-value compute/region)

tput setaf 3
echo 'DONE.'
echo ''


tput setaf 3
echo ''
echo 'INIT Compute Instance...'
echo '=============================='
tput sgr0

for i in 0 1 2; do
  gcloud compute instances create controller-${i} \
    --async \
    --boot-disk-size 200GB \
    --can-ip-forward \
    --image-family ubuntu-2004-lts \
    --image-project ubuntu-os-cloud \
    --machine-type e2-standard-2 \
    --private-network-ip 10.240.0.1${i} \
    --scopes compute-rw,storage-ro,service-management,service-control,logging-write,monitoring \
    --subnet kubernetes \
    --tags kubernetes-the-hard-way,controller
done

for i in 0 1 2; do
  gcloud compute instances create worker-${i} \
    --async \
    --boot-disk-size 200GB \
    --can-ip-forward \
    --image-family ubuntu-2004-lts \
    --image-project ubuntu-os-cloud \
    --machine-type e2-standard-2 \
    --metadata pod-cidr=10.200.${i}.0/24 \
    --private-network-ip 10.240.0.2${i} \
    --scopes compute-rw,storage-ro,service-management,service-control,logging-write,monitoring \
    --subnet kubernetes \
    --tags kubernetes-the-hard-way,worker
done

tput setaf 3
echo 'DONE.'
echo ''

tput setaf 3
echo ''
echo 'Configuring SSH Access...'
echo '=============================='
tput sgr0

gcloud compute ssh controller-0

tput setaf 3
echo 'DONE.'
echo ''