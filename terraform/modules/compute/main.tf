resource "aws_lightsail_instance" "k3s_server" {
  name              = var.server_name
  availability_zone = "eu-central-1a"
  blueprint_id      = "ubuntu_24_04"
  bundle_id         = var.bundle_id
  key_pair_name     = "n8nkey"
}
