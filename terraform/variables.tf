variable "aws_region" {
  description = "AWS region where resources will be provisioned"
  default     = "us-east-1"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  default     = "ami-0150ccaf51ab55a51"
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  default     = "t2.large"
}
