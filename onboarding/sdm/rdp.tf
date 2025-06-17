resource "sdm_resource" "windows_server" {
  rdp {
    name     = "${var.name}-rdp"
    hostname = var.rdp_hostname
    port     = 3389
    username = "Administrator"
    password = rsadecrypt(var.rdp_password, var.rdp_private_key)
    tags     = merge({ Name = "${var.name}-rdp" }, var.tags)

    proxy_cluster_id = var.proxy_cluster_id
  }
}