provider "aws" {
  version = "3.50.0"
  region  = "us-east-1"
}

variable "vpc_cidr_block" {
  type        = string
  description = "vpc cidr block"
  default     = "10.1.0.0/16"
}

variable "instance_tenancy_type" {
  type        = string
  description = "instance_tenancy_type"
  default     = "default"
}

variable "vpc_tags" {
  type        = map(string)
  description = "tags to be added for vpc"
  default = {
    "Name" = "seetha_vpc_test"
    "CreatedVia" = "tf"
  }
}


resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = var.instance_tenancy_type

  tags = var.vpc_tags
}

