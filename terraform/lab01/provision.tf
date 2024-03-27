resource "null_resource" "controller_provision" {
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get -y update",
      "sudo apt-get -y install ansible git",
      "mkdir -p /home/rooty/.ssh",
      "echo '${tls_private_key.ssh_key_linux_openssh.private_key_openssh}' > /home/rooty/.ssh/id_rsa",
      "chmod 600 /home/rooty/.ssh/id_rsa"
    ]
    connection {
      type        = "ssh"
      host        = azurerm_public_ip.pubip_controller.ip_address
      user        = "rooty"
      private_key = tls_private_key.ssh_key_linux_openssh.private_key_openssh
    }
  }
  depends_on = [ tls_private_key.ssh_key_linux_openssh ]
}