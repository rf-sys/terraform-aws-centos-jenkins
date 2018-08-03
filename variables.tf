# provider

variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {}

# instance

variable "aws_instance_ami" {
  # Default CentOS AMI. Last check: 02.08.2018
  default = "ami-dd3c0f36"
}
variable "aws_instance_type" {}
variable "aws_instance_name" {}

# security group

variable "aws_security_group_name" {}

# ssh-key

variable "aws_key_pair_name" {}
variable "aws_key_pair_public_key_path" {}
variable "aws_key_pair_private_key_path" {}

# Jenkins

# Jenkins's initialAdminPassword will be displayed eventually
# default: false
variable "show_jenkins_password" {
  default = 0
}

# Testing

# attaches uniq hash to the end resources' name (used for parallel testing)
# default: false
variable "attach_test_uids" {
  default = 0
}
