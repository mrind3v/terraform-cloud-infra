#!/usr/bin/env bash
# Runs each demo command and pauses so you can take a screenshot (Cmd+Shift+4).
# Usage: ./screenshot-steps.sh   (LocalStack must be running)
export AWS_ACCESS_KEY_ID=test AWS_SECRET_ACCESS_KEY=test AWS_DEFAULT_REGION=ap-south-1
EP="--endpoint-url=http://localhost:4566"

step() {
  clear
  echo "=== $1 ==="; echo "\$ ${*:2}"; echo
  eval "${*:2}"
  echo; read -rp ">> Take screenshot '$1', then press Enter..."
}

step "01-localstack-health"  "curl -s http://localhost:4566/_localstack/health | head -c 300; echo"
step "02-terraform-init"     "terraform init"
step "03-terraform-validate" "terraform fmt -check && terraform validate"
step "04-terraform-plan"     "terraform plan"
step "05-terraform-apply"    "terraform apply -auto-approve"
step "06-terraform-output"   "terraform output"
step "07-terraform-state"    "terraform state list"
step "08-aws-vpc-subnet"     "aws ec2 describe-vpcs $EP --filters Name=tag:Name,Values=session19-mini-vpc --query 'Vpcs[].{VpcId:VpcId,Cidr:CidrBlock}' --output table; aws ec2 describe-subnets $EP --filters Name=tag:Name,Values=session19-mini-public-subnet --query 'Subnets[].{SubnetId:SubnetId,Cidr:CidrBlock,AZ:AvailabilityZone}' --output table"
step "09-aws-sg-ec2-s3"      "aws ec2 describe-security-groups $EP --filters Name=group-name,Values=session19-mini-web-sg --query 'SecurityGroups[].{GroupId:GroupId,Name:GroupName}' --output table; aws ec2 describe-instances $EP --query 'Reservations[].Instances[].{Id:InstanceId,Type:InstanceType,Subnet:SubnetId,State:State.Name}' --output table; aws s3 ls $EP"
step "10-terraform-plan-destroy" "terraform plan -destroy"
step "11-terraform-destroy"  "terraform destroy -auto-approve"
step "12-state-empty-after-destroy" "terraform state list; echo '(empty = all resources destroyed)'"
