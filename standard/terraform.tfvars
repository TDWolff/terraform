## AWS Environment settings
ssh_authorized_keys = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC/lOibY5TnfqvJGfGORbAVcolB6Drp8UQcly0Y3NfuzsWZt4nqmACGIp0fdNtlcgb7VB1HguLJaFjYam1OUGv/dDW5j1iAB15OgdOUPo92FOoQ8qLgzFq52gv3rJOOJbe+6+HBNQbRrqGvO0W9Oc1ag5hft1gtyFX08yDLTndBdIKGcjWsbSYovkKSIan4l/CPVVadD1VxRQDa2B8KX+5YAM8wfG8oX0HZpzn5PxtY1dPFeVtLFu9K/DMKZEPElAUce2Wx4wyuHCFLDmpqddp6wUAjtYHtEgufWvt3/rBBt5yMGLuYMJfN0xvDbB4ose4pu5fHPj+SLoAD56ailCCy3EMmRHrjkGqY/Tvx8aeapQ+VpYN50nYLz3L0DVanFdA84smOv5b4FgLgU7Sqku0/hCwqTpxuF+L2y1TbiYoPADtmz23XTpg+5fZTWzOaUieOsMAVPATWJ2fJEt5n5Jb89euZVCF1wNx8OMCV4ARZw/KfILsDaccJcQRu7Dv0jZx0T61WJ3Vxq7duuh9fdehuradgd24qLvYPpWCU+y4DgxWENmR5aaffrUPIL3ckpzXbSgoGeL7kH553yp4A5NKaNezE9mmWPV7jS+2PYkbO5tsXF2KbdZ0g8ZAEZl2gXLfNJ5DjXzy3F8ZwEDbBj5c0DQHvYsaY4X1w0U/Sa4R5fQ== rjaiswal.sd.77@gmail.com"  # Your SSH public key
aws_region          = "us-west-1"
aws_domain_name     = "kasm.nighthawkcodingsociety.com"
vpc_subnet_cidr     = "10.0.0.0/16"

## Kasm deployment settings
kasm_zone_name = "ncskasm"
project_name   = "ncskasm"

## Number of each Kasm role to deploy
num_agents    = 2
num_webapps   = 2
num_cpx_nodes = 1

## VM Public Access subnets
web_access_cidrs = ["0.0.0.0/0"]

## AWS SSM setup for console/SSH access to VMs behind NAT gateway
create_aws_ssm_iam_role       = true
aws_ssm_iam_role_name         = "ncskasm"
aws_ssm_instance_profile_name = "ncskasm"

## Kasm Server settings
ec2_ami_id = "ami-0ca1f30768d0cf0e1"
swap_size  = 2

## Kasm Webapp Instance Settings
webapp_instance_type = "t3.small"
webapp_hdd_size_gb   = 8

## Kasm DB Instance Settings
db_instance_type = "t3.medium"
db_hdd_size_gb   = 8

## Kasm Agent Instance Settings
agent_instance_type = "t3.medium"
agent_hdd_size_gb   = 8

## Kasm CPX Instance Settings
cpx_instance_type = "t3.small"
cpx_hdd_size_gb   = 8

## Kasm passwords
database_password          = "KasmVersion2"
redis_password             = "KasmVersion2"
user_password              = "KasmVersion2"
admin_password             = "KasmVersion2"
manager_token              = "KasmVersion2"
service_registration_token = "KasmVersion2"

## Kasm download URL
kasm_build = "https://kasm-static-content.s3.amazonaws.com/kasm_release_1.15.0.06fdc8.tar.gz"

## Default tags for all AWS resources
aws_default_tags = {
  Deployed_by     = "Terraform"
  Deployment_type = "Multi-Server"
  Service_name    = "Kasm Workspaces"
  Kasm_version    = "1.15"
}