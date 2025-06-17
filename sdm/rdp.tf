resource "sdm_resource" "windows_server" {
  rdp {
    name     = "${var.name}-rdp"
    hostname = aws_instance.windows_server.private_ip
    port     = 3389
    username = "Administrator"
    password = rsadecrypt(aws_instance.windows_server.password_data, tls_private_key.windows_server.private_key_pem)
    tags     = merge({ Name = "${var.name}-rdp" }, var.tags)

    proxy_cluster_id = var.proxy_cluster_id
  }
}