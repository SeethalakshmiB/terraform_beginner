# AWS Key Pair - Wordpress server key pair
resource "aws_key_pair" "pac_key" {
    key_name = "${var.project}-key"
    public_key = file(var.ssh_public_key_path)
}