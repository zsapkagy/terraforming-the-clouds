# Create EC2 instance

## Security group

Create Security group for the EC2 instance

```
aws ec2 create-security-group --group-name gcp-sg --description "Google Cloud EC2 security group"
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

Create an EC2 instance with the required characteristics

- AMI: Amazon Linux 2 AMI (ami-058e6df85cfc7760b)
- type: t2.micro

```
aws ec2 run-instances --image-id ami-058e6df85cfc7760b --instance-type t2.micro --key-name <AWS_KEY_PAIR_NAME_PEM_FILE> --security-groups <PREVIOUSLY_CREATED_GROUP_NAME> --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=Minikube}]'
```

```
aws ec2 run-instances --image-id ami-058e6df85cfc7760b --instance-type t2.micro --key-name user-ec2-key --security-groups gcp-sg --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=GCP-kubernetes}]'
```

## Connect to the EC2 instance (SSH)

```
ssh -i <AWS_KEY_PAIR_NAME_PEM_FILE> ec2-user@<PUBLIC_ID_OF_THE_INSTANCE>
```

## Install GCP

Amazon Linux is a CentOs like OS so we could use the install guide from there

https://cloud.google.com/sdk/docs/install#rpm
