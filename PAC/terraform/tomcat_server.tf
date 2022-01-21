# AWS Security Group
resource "aws_security_group" "docker_server_sg" {
    name = "${var.project}_docker_sg"
    description = "EC2 Security Group for ${var.project} docker Application"
    vpc_id = var.vpc_id
    tags = {
    Name = "${var.project}_docker_sg"
  }
}

# SSH --> Inbound 
resource "aws_security_group_rule" "ssh" {
  from_port = 22
  to_port = 22
  protocol = "tcp"
  security_group_id = aws_security_group.docker_server_sg.id
  type = "ingress"
  cidr_blocks = [ "0.0.0.0/0" ]
}

# Outbound --> Internet
resource "aws_security_group_rule" "egress" {
  from_port = 0 # ---> all port
  to_port = 0
  protocol = -1 # or all
  security_group_id = aws_security_group.docker_server_sg.id
  type = "egress"
  cidr_blocks = [ "0.0.0.0/0" ]
}

# resource "aws_instance" "docker_server" {
#     ami = var.ec2_ami_id
#     instance_type = var.instance_type
#     key_name = aws_key_pair.pac_key.key_name
#     subnet_id = var.public_subnet_id
#     vpc_security_group_ids = [ aws_security_group.docker_server_sg.id ]

#     tags = {
#         Name = "${var.project}_docker_server"
#     }
# }

resource "aws_instance" "docker_server_1" {
    ami = var.ec2_ami_id
    instance_type = var.instance_type
    key_name = aws_key_pair.pac_key.key_name
    subnet_id = var.public_subnet_id
    vpc_security_group_ids = [ aws_security_group.docker_server_sg.id ]
    user_data = <<EOF
#!/bin/bash

sudo yum install -y yum-utils 

sudo yum-config-manager --add-repo  https://download.docker.com/linux/centos/docker-ce.repo 

sudo yum install docker-ce docker-ce-cli containerd.io -y

sudo systemctl start docker
EOF
    tags = {
        Name = "${var.project}_docker_server_1"
    }
}
