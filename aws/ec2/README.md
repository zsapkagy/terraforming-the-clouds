# EC2 instances - OUTDATED

Init scripts and info how to acces the instances

# Create/use a Key Pair

Create a Key Pair to be able to access the EC2 instance later.

On the AWS console create a new Key Pair and put the auto-downloaded file where you won't loose it.

Chmod the the permission of the `pem` file

```
chmod 400 <NAME_OF_THE_KEY_FILE>.pem
```

Check for existing one

```
aws ec2 describe-key-pairs
```
