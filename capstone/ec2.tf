# # RSA Keys
# resource "tls_private_key" "ssh_key" {
#   algorithm = "RSA"
#   rsa_bits = 4096
# }

# # Store Private Key (pem) in pem folder
# resource "null_resource" "copy_private_key" {
#     provisioner "local-exec" {
#       command = "mkdir -p ./pem; echo \"${tls_private_key.ssh_key.private_key_pem}\" > \"./pem/ec2.pem\"; chmod 400 ./pem/ec2.pem"
#     } 
# }
# output "private_key" {
#   value = tls_private_key.ssh_key.private_key_pem
# }

# output "public_key" {
#   value = tls_private_key.ssh_key.public_key_openssh
# }

# AWS Key Pair - Wordpress server key pair
resource "aws_key_pair" "wordpress_key" {
    key_name = "${var.project}-key"
    public_key = file(var.ssh_public_key)
}

# AWS Security Group
resource "aws_security_group" "wp_server_sg" {
    name = "${var.project}_ec2_wp_sg"
    description = "EC2 Security Group for ${var.project} Wordpress Application"
    vpc_id = aws_vpc.main.id
    tags = {
    Name = "${var.project}_ec2_wp_sg"
  }
}

# SSH --> Inbound 
resource "aws_security_group_rule" "ssh" {
  from_port = 22
  to_port = 22
  protocol = "tcp"
  security_group_id = aws_security_group.wp_server_sg.id
  type = "ingress"
  cidr_blocks = [ "0.0.0.0/0" ]
}

# Outbound --> Internet
resource "aws_security_group_rule" "egress" {
  from_port = 0 # ---> all port
  to_port = 0
  protocol = -1 # or all
  security_group_id = aws_security_group.wp_server_sg.id
  type = "egress"
  cidr_blocks = [ "0.0.0.0/0" ]
}

resource "aws_instance" "wp_ec2_server" {
    ami = var.ec2_ami_id
    instance_type = var.instance_type
    key_name = aws_key_pair.wordpress_key.key_name
    subnet_id = aws_subnet.public_subnet_2.id
    vpc_security_group_ids = [ aws_security_group.wp_server_sg.id ]

    tags = {
        Name = "${var.project}_wp_server"
    }
}