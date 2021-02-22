resource "digitalocean_droplet" "qortal-node" {
  image = "ubuntu-20-04-x64"
  name = "qortal-node"
  region = "sfo3"
  size = "s-1vcpu-2gb"
  private_networking = true
  ssh_keys = [
    data.digitalocean_ssh_key.main.id
  ]

  connection {
    host = self.ipv4_address
    user = "root"
    type = "ssh"
    private_key = file(var.pvt_key)
    timeout = "2m"
  }

  provisioner "file" {
    source = "qortal_bootstrap.sh"
    destination = "/opt/qortal_bootstrap.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /opt/qortal_bootstrap.sh",
      "/opt/qortal_bootstrap.sh",
    ]
  }
}
