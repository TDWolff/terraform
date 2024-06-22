variable "aws_access_key" {
  description = "The AWS access key used for deployment"
  type        = string
  sensitive   = true

  validation {
    condition     = can(regex("^([A-Z0-9]{20})", var.aws_access_key))
    error_message = "The aws_access_key variable must be a valid AWS Access Key (e.g. AKIAJSIE27KKMHXI3BJQ)."
  }
}

variable "aws_secret_key" {
  description = "The AWS secret key used for deployment"
  type        = string
  sensitive   = true

  validation {
    condition     = can(regex("^([a-zA-Z0-9+\\/-]{40})", var.aws_secret_key))
    error_message = "The aws_secret_key variable must be a valid AWS Secret Key value (e.g. wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY)"
  }
}

variable "aws_region" {
  description = "The AWS Region used for deployment"
  type        = string
  default     = "us-east-1"

  validation {
    condition     = can(regex("^([a-z]{2}-[a-z]{4,}-[\\d]{1})$", var.aws_region))
    error_message = "The aws_region must be a valid Amazon Web Services (AWS) Region name, e.g. us-east-1"
  }
}

variable "project_name" {
  description = "The name of the deployment (e.g dev, staging). A short single word"
  type        = string

  validation {
    condition     = can(regex("^[a-z]{4,15}", var.project_name))
    error_message = "The project_name variable can only be one word between 4 and 15 lower-case letters since it is a seed value in multiple object names."
  }
}

variable "kasm_zone_name" {
  description = "A name given to the kasm deployment Zone"
  type        = string
  default     = "default"

  validation {
    condition     = can(regex("^[a-z0-9A-Z-_]{4,15}", var.kasm_zone_name))
    error_message = "The kasm_zone_name variable can only be one word between 4 and 15 characters consisting of letters, numbers, dash (-), and underscore (_)."
  }
}

variable "aws_domain_name" {
  description = "The Route53 Zone used for the dns entries. This must already exist in the AWS account. (e.g dev.kasm.contoso.com). The deployment will be accessed via this zone name via https"
  type        = string

  validation {
    condition     = can(regex("(?:[a-z0-9](?:[a-z0-9-]{0,61}[a-z0-9])?\\.)+[a-z0-9][a-z0-9-]{0,61}[a-z0-9]", var.aws_domain_name))
    error_message = "There are invalid characters in the aws_domain_name - it must be a valid domain name."
  }
}

variable "vpc_subnet_cidr" {
  description = "The subnet CIDR to use for the VPC"
  type        = string
  default     = "10.0.0.0/16"

  validation {
    condition     = can(cidrhost(var.vpc_subnet_cidr, 0))
    error_message = "The VPC subnet must be valid IPv4 CIDR."
  }
}

variable "swap_size" {
  description = "The amount of swap (in GB) to configure inside the compute instances"
  type        = number

  validation {
    condition     = var.swap_size >= 1 && var.swap_size <= 8 && floor(var.swap_size) == var.swap_size
    error_message = "Swap size is the amount of disk space to use for Kasm in GB and must be an integer between 1 and 8."
  }
}

variable "webapp_instance_type" {
  description = "The instance type for the webapps"
  type        = string

  validation {
    condition     = can(regex("^(([a-z-]{1,3})(\\d{1,2})?(\\w{1,4})?)\\.(nano|micro|small|medium|metal|large|(2|3|4|6|8|9|10|12|16|18|24|32|48|56|112)?xlarge)", var.webapp_instance_type))
    error_message = "Check the webapp_instance_type variable and ensure it is a valid AWS Instance type (https://aws.amazon.com/ec2/instance-types/)."
  }
}

variable "db_instance_type" {
  description = "The instance type for the Database"
  type        = string

  validation {
    condition     = can(regex("^(([a-z-]{1,3})(\\d{1,2})?(\\w{1,4})?)\\.(nano|micro|small|medium|metal|large|(2|3|4|6|8|9|10|12|16|18|24|32|48|56|112)?xlarge)", var.db_instance_type))
    error_message = "Check the db_instance_type variable and ensure it is a valid AWS Instance type (https://aws.amazon.com/ec2/instance-types/)."
  }
}

variable "agent_instance_type" {
  description = "The instance type for the Agents"
  type        = string

  validation {
    condition     = can(regex("^(([a-z-]{1,3})(\\d{1,2})?(\\w{1,4})?)\\.(nano|micro|small|medium|metal|large|(2|3|4|6|8|9|10|12|16|18|24|32|48|56|112)?xlarge)", var.agent_instance_type))
    error_message = "Check the agent_instance_type variable and ensure it is a valid AWS Instance type (https://aws.amazon.com/ec2/instance-types/)."
  }
}

variable "cpx_instance_type" {
  description = "The instance type for the cpxamole RDP nodes"
  type        = string

  validation {
    condition     = can(regex("^(([a-z-]{1,3})(\\d{1,2})?(\\w{1,4})?)\\.(nano|micro|small|medium|metal|large|(2|3|4|6|8|9|10|12|16|18|24|32|48|56|112)?xlarge)", var.cpx_instance_type))
    error_message = "Check the cpx_instance_type variable and ensure it is a valid AWS Instance type (https://aws.amazon.com/ec2/instance-types/)."
  }
}

variable "num_webapps" {
  description = "The number of WebApp role servers to create in the deployment"
  type        = number

  validation {
    condition     = var.num_webapps >= 1 && var.num_webapps <= 6 && floor(var.num_webapps) == var.num_webapps
    error_message = "Acceptable number of webapps range between 1-6."
  }
}

variable "num_agents" {
  description = "The number of Agent Role Servers to create in the deployment"
  type        = number

  validation {
    condition     = var.num_agents >= 0 && var.num_agents <= 100 && floor(var.num_agents) == var.num_agents
    error_message = "Acceptable number of Kasm Agents range between 0-100."
  }
}

variable "num_cpx_nodes" {
  description = "The number of Agent Role Servers to create in the deployment"
  type        = number

  validation {
    condition     = var.num_cpx_nodes == 0 ? true : var.num_cpx_nodes >= 0 && var.num_cpx_nodes <= 100 && floor(var.num_cpx_nodes) == var.num_cpx_nodes
    error_message = "If num_cpx_nodes is set to 0, this Terraform will not deploy the Connection Proxy node. Acceptable number of Kasm Agents range between 0-100."
  }
}

variable "webapp_hdd_size_gb" {
  description = "The HDD size in GB to configure for the Kasm WebApp instances"
  type        = number

  validation {
    condition     = can(var.webapp_hdd_size_gb >= 40)
    error_message = "Kasm Webapps should have at least a 40 GB HDD to ensure enough space for Kasm services."
  }
}

variable "db_hdd_size_gb" {
  description = "The HDD size in GB to configure for the Kasm Database instances"
  type        = number

  validation {
    condition     = can(var.db_hdd_size_gb >= 40)
    error_message = "Kasm Database should have at least a 40 GB HDD to ensure enough space for Kasm services."
  }
}

variable "agent_hdd_size_gb" {
  description = "The HDD size in GB to configure for the Kasm Agent instances"
  type        = number

  validation {
    condition     = can(var.agent_hdd_size_gb >= 120)
    error_message = "Kasm Agents should have at least a 120 GB HDD to ensure enough space for Kasm services."
  }
}

variable "cpx_hdd_size_gb" {
  description = "The HDD size in GB to configure for the Kasm cpx RDP instances"
  type        = number

  validation {
    condition     = can(var.cpx_hdd_size_gb >= 40)
    error_message = "Kasm cpx RDP nodes should have at least a 40 GB HDD to ensure enough space for Kasm services. If num_cpx_nodes is set to 0 this setting is ignored."
  }
}

variable "web_access_cidrs" {
  description = "CIDR notation of the bastion host allowed to SSH in to the machines"
  type        = list(string)

  validation {
    condition     = alltrue([for subnet in var.web_access_cidrs : can(cidrhost(subnet, 0))])
    error_message = "One of the subnets provided in the load_balancer_public_access variable is invalid."
  }
}

variable "ec2_ami_id" {
  description = "The AMI used for the EC2 nodes. Recommended Ubuntu 22.04 LTS."
  type        = string

  validation {
    condition     = can(regex("^(ami-[a-f0-9]{17})", var.ec2_ami_id))
    error_message = "Please verify that your AMI is in the correct format for AWS (https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/finding-an-ami.html)."
  }
}

variable "ssh_authorized_keys" {
  description = "The SSH Public Keys to be installed on the OCI compute instance"
  type        = string

  validation {
    condition     = var.ssh_authorized_keys == "" ? true : can(regex("^(ssh-rsa|ssh-ed25519)", var.ssh_authorized_keys))
    error_message = "The ssh_authorized_keys value is not in the correct format."
  }
}

variable "database_password" {
  description = "The password for the database. No special characters"
  type        = string
  sensitive   = true

  validation {
    condition     = can(regex("^[a-zA-Z0-9]{12,30}$", var.database_password))
    error_message = "The Database Password should be a string between 12 and 30 letters or numbers with no special characters."
  }
}

variable "redis_password" {
  description = "The password for the Redis server. No special characters"
  type        = string
  sensitive   = true

  validation {
    condition     = can(regex("^[a-zA-Z0-9]{12,30}$", var.redis_password))
    error_message = "The Redis Password should be a string between 12 and 30 letters or numbers with no special characters."
  }
}

variable "user_password" {
  description = "The standard (non administrator) user password. No special characters"
  type        = string
  sensitive   = true

  validation {
    condition     = can(regex("^[a-zA-Z0-9]{12,30}$", var.user_password))
    error_message = "The User Password should be a string between 12 and 30 letters or numbers with no special characters."
  }
}

variable "admin_password" {
  description = "The administrative user password. No special characters"
  type        = string
  sensitive   = true

  validation {
    condition     = can(regex("^[a-zA-Z0-9]{12,30}$", var.admin_password))
    error_message = "The Admin password should be a string between 12 and 30 letters or numbers with no special characters."
  }
}

variable "manager_token" {
  description = "The manager token value for Agents to authenticate to webapps. No special characters"
  type        = string
  sensitive   = true

  validation {
    condition     = can(regex("^[a-zA-Z0-9]{12,30}$", var.manager_token))
    error_message = "The Manager Token should be a string between 12 and 30 letters or numbers with no special characters."
  }
}

variable "service_registration_token" {
  description = "The service registration token value for cpx RDP servers to authenticate to webapps. No special characters"
  type        = string
  sensitive   = true

  validation {
    condition     = can(regex("^[a-zA-Z0-9]{12,30}$", var.service_registration_token))
    error_message = "The Service Registration Token should be a string between 12 and 30 letters or numbers with no special characters."
  }
}

variable "create_aws_ssm_iam_role" {
  description = "Create an AWS SSM IAM role to attach to VMs for SSH/console access to VMs."
  type        = bool
  default     = false

  validation {
    condition     = can(tobool(var.create_aws_ssm_iam_role))
    error_message = "The create_aws_ssm_iam_role is a boolean value and can only be either true or false."
  }
}

variable "aws_ssm_iam_role_name" {
  description = "The name of the SSM EC2 role to associate with Kasm VMs for SSH access"
  type        = string
  default     = ""

  validation {
    condition     = can(regex("[a-zA-Z0-9+=,.@-]{1,64}", var.aws_ssm_iam_role_name))
    error_message = "The aws_ssm_iam_role_name must be unique across the account and can only consisit of between 1 and 64 characters consisting of letters, numbers, underscores (_), plus (+), equals (=), comman (,), period (.), at symbol (@), or dash (-)."
  }
}

variable "aws_ssm_instance_profile_name" {
  description = "The name of the SSM EC2 Instance Profile to associate with Kasm VMs for SSH access"
  type        = string
  default     = ""

  validation {
    condition     = var.aws_ssm_instance_profile_name == "" ? true : can(regex("[a-zA-Z0-9+=,.@-]{1,64}", var.aws_ssm_instance_profile_name))
    error_message = "The aws_ssm_instance_profile_name must be unique across the account and can only consisit of between 1 and 64 characters consisting of letters, numbers, underscores (_), plus (+), equals (=), comman (,), period (.), at symbol (@), or dash (-)."
  }
}

## Non-validated variables
variable "kasm_build" {
  description = "The URL for the Kasm Workspaces build"
  type        = string
}

variable "aws_default_tags" {
  description = "Default tags to apply to all AWS resources for this deployment"
  type        = map(any)
  default     = {}
}
