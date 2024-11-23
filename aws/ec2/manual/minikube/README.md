# Create EC2 instance for the minikube

## Security group

Create Security group for the EC2 instance

```
aws ec2 create-security-group --group-name Minikube --description "Minikube Security Group"
```

Check existing security groups

```
aws ec2 describe-security-groups

# or for only the ids execute this:
aws ec2 describe-security-groups | grep 'GroupId\|GroupName'
```

Add Inbound rule

```
aws ec2 authorize-security-group-ingress --group-id <PREVIOUSLY_CREATED_GROUP_ID> --protocol tcp --port 22 --cidr 0.0.0.0/0
```

## Create an EC2 instance

Create an EC2 instance with the required characteristics to be able to run Minikube on it

- AMI: Ubuntu latest (18.4 for now) (ami-0b1deee75235aa4bb)
- type: t2.medium

```
aws ec2 run-instances --image-id ami-0b1deee75235aa4bb --instance-type t2.medium --key-name <AWS_KEY_PAIR_NAME_PEM_FILE> --security-groups <PREVIOUSLY_CREATED_GROUP_NAME> --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=Minikube}]'
```

```
aws ec2 run-instances --image-id ami-0b1deee75235aa4bb --instance-type t2.medium --key-name user-ec2-key --security-groups Minikube --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=Minikube}]'
```

Get the just created EC2 instance id

```
aws ec2 describe-instances | grep -E 'PublicIp|Status|InstanceId|KeyName'
```

Tag the instance later

```
aws ec2 create-tags --resources <INSTANCE_ID> --tags Key=Name,Value='Minikube'
```

## Install packages

Copy the bootstrap script to the EC2 instance's home (`~/home/ubuntu/`)

```
scp -i <AWS_KEY_PAIR_NAME_PEM_FILE> ./minikube/minikube-bootstrap.sh ubuntu@<PUBLIC_ID_OF_THE_INSTANCE>:
```

## Connect to the EC2 instance (SSH)

```
ssh -i <AWS_KEY_PAIR_NAME_PEM_FILE> ubuntu@<PUBLIC_ID_OF_THE_INSTANCE>
```

Execute the bootstrap script

```
# Make it executable
chmod +x ./minikube/minikube-bootstrap.sh
chmod +x ./minikube/minikube-bootstrap-root.sh

./minikube/minikube-bootstrap.sh
```

### Be the root user

```
sudo -i
```

Execute the root-bootstrap steps

```
./minikube/minikube-bootstrap-root.sh
```

#### Start Minikube

```
minikube start --driver=none
#Get Minikube status
minikube status
```

## Connect to Minikube dashboard

Start the minikube dashboard

```
minikube dashboard --url
```

Get the PORT number from the url!

We should create an ssh tunnel to the EC2 instance

```
ssh -i <AWS_KEY_PAIR_NAME_PEM_FILE> -L <LOCAL PORT>:localhost:<REMOTE PORT ON WHICH MINIKUBE DASHBOARD IS RUNNING> ubuntu@<PUBLIC_ID_OF_THE_INSTANCE>

# example:
ssh -i user-ec2-key.pem -L 8081:localhost:36749 ubuntu@18.185.3.152
```

## Access the kubernates api

https://learning.edx.org/course/course-v1:LinuxFoundationX+LFS158x+3T2020/block-v1:LinuxFoundationX+LFS158x+3T2020+type@sequential+block@7b044c7dafae45a7a3c4773195b8f11b/block-v1:LinuxFoundationX+LFS158x+3T2020+type@vertical+block@**49866078f2a54a208b57ce783b59ec2e**

# Links

- [Setup with CLI](https://www.australtech.net/cka-certified-kubernetes-administrator-training-minikube/)
- [Setup with Console](https://www.bogotobogo.com/DevOps/Docker/Docker-Kubernetes-Minikube-install-on-AWS-EC2.php)
- [Setup with Console - with Minikube dashboard](https://aws.plainenglish.io/running-kubernetes-using-minikube-cluster-on-the-aws-cloud-4259df916a07)
- [Setup with Console 02](https://www.radishlogic.com/kubernetes/running-minikube-in-aws-ec2-ubuntu/)
- [EC2 setup with AWS CLI](https://www.australtech.net/aws-certification-amazon-elastic-compute-cloud-ec2/)
- [User data to bootstart script](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/user-data.html)
- [Connect to Minikube dashboard](https://shubham-singh98.medium.com/minikube-dashboard-in-aws-ec2-881143a2209e)
