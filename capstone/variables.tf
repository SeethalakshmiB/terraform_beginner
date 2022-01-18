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
