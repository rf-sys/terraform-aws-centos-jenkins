Terraform-aws-centos-jenkins
======

[![Build Status](https://travis-ci.org/salvatoris/terraform-aws-centos-jenkins.svg?branch=master)](https://travis-ci.org/salvatoris/terraform-aws-centos-jenkins)

Installs Jenkins and Nginx on EC2 CentOS.

Nginx works as a proxy from 80 to 8080 port

CentOS AMI details: [CentOS AMI on AWS Marketplace](https://aws.amazon.com/marketplace/pp/B00O7WM7QW?ref=cns_1clkPro)

Terraform module: [Terraform registry](https://registry.terraform.io/modules/sorenrix/centos-jenkins/aws)

Resources
------
Creates next resources on AWS:
1. EC2 instance (jenkins-server)
2. security group for jenkins-server
3. key_pair for ssh access to jenkins-server

Variables
------
Variables that are used by this module:
1. aws_access_key - AWS account public key
2. aws_secret_key - AWS account private key
3. aws_region - AWS region
4. aws_instance_ami - CentOS AMI ID (default: ami-dd3c0f36). Last updated: 03.08.2018
5. aws_instance_type - EC2 instance Type (example: t2.micro)
6. aws_instance_name - EC2 instance name
7. aws_security_group_name - name of new security group
8. aws_key_pair_name - name of new key_pair
9. aws_key_pair_public_key_path - path to ssh public key (example: /home/admin/.ssh/id_rsa.pub)
10. aws_key_pair_private_key_path - path to ssh private key (example: /home/admin/.ssh/id_rsa)
11. show_jenkins_password - show initialAdminPassword eventually (default: 0 - false) 
12. attach_test_uids - attach uniq hash to resources' names (default: 0 - false) 

Example Configuration
------
https://gist.github.com/salvatoris/f45e717433a6f09482963fbd01d24206

Example Output
------
https://gist.github.com/salvatoris/1de5b5408303eb554305a876aa0ce846

FAQ
-----
1. How to get info about latest CentOS AMI ?

See https://wiki.centos.org/Cloud/AWS
