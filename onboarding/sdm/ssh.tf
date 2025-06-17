resource "sdm_resource" "ssh_ec2" {
  ssh_cert {
    name     = "${var.name}-ssh"
    username = "ec2-user"
    hostname = var.ssh_hostname
    port     = 22
    tags     = merge({ Name = "${var.name}-ssh" }, var.tags)

    proxy_cluster_id = var.proxy_cluster_id
  }
}

