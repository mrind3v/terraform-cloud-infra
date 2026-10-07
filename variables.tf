variable "aws_region" {
  description = "AWS region for the Session 19 mini project."
  type        = string
  default     = "ap-south-1"
}

variable "use_localstack" {
  description = "true = deploy to LocalStack (no AWS account needed), false = deploy to real AWS."
  type        = bool
  default     = true
}

variable "localstack_endpoint" {
  description = "LocalStack edge endpoint."
  type        = string
  default     = "http://localhost:4566"
}

variable "ami_id" {
  description = "AMI for the EC2 instance. Any ami-* id works on LocalStack; use a real AMI for your region on AWS."
  type        = string
  default     = "ami-0c55b159cbfafe1f0"
}

variable "instance_type" {
  description = "EC2 instance type."
  type        = string
  default     = "t3.micro"
}

variable "bucket_name" {
  description = "S3 bucket name (must be globally unique on real AWS)."
  type        = string
  default     = "session19-mini-bucket-mrind3v"
}
