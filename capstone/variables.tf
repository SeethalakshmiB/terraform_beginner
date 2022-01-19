# vpc_cidr
variable "vpc_cidr_block" {
  type        = string
  description = "vpc cidr block"
  default     = "10.1.0.0/16"
}

#vpc_tenancy type
variable "instance_tenancy_type" {
  type        = string
  description = "instance_tenancy_type"
  default     = "default"
}

variable "project" {
    type = string
    description = "project name"
    default = "capstone"
}

variable "db_password" {
    type = string
    description = "db password"
    default = "admin-123"
}


variable "ec2_ami_id"{
    type = string
    description = "Redhat AMI Id for Wordpress EC2 Server"
    default = "ami-0b0af3577fe5e3532"
}

variable "instance_type" {
  type = string
  description = "ec2 instance type"
  default = "t2.micro"
}

variable "ssh_public_key" {
    type = string
    description = "SSH RSA Public Key"
    default = "./pem/public_key.pub"
}