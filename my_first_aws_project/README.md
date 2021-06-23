# My First Terraform Project

## Setup
- Install Terraform
- Setup AWS access. Need programmatic access, so a user with programmatic capabilities. Need a Key Pair
- Setup environment variables
~~~~
export AWS_ACCESS_KEY_ID="..."
export AWS_SECRET_ACCESS_KEY="..."
export AWS_DEFAULT_REGION="us-east-1"
~~~~

## Run Terraform
~~~~
  terraform init
  terraform plan
  terraform apply
  ...instance is running here, when done, then run 
  terraform destroy
~~~~

## SSH into Instance
~~~~
ssh -i ~/Downloads/YetAnotherKeyPair.pem ubuntu@ec2-XXX-XXX-XXX-XXX.compute-1.amazonaws.com
~~~~