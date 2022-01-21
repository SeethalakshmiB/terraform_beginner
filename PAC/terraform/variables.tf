variable "project" {
    type = string
    description = "project name"
    default = "pac"
}

variable "vpc_id" {
    type = string
    description = "vpc id"
}

variable "ssh_public_key_path" {
    type =  string
    description = "ssh public key file path"
}

variable "public_subnet_id" {
  type = string
}

variable "ec2_ami_id"{
    type = string
    description = "Redhat AMI Id for Tomcat EC2 Server"
    default = "ami-0b0af3577fe5e3532"
}

variable "instance_type" {
  type = string
  description = "ec2 instance type"
  default = "t2.micro"
}
