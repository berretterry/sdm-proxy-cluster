resource "sdm_resource" "web_page" {
  http_no_auth {
    name             = "${var.name}-http"
    url              = "http://${var.ssh_hostname}"
    default_path     = "/"
    healthcheck_path = "/"
    subdomain        = "simple-web-page"

    proxy_cluster_id = var.proxy_cluster_id

    tags = merge({ Name = "${var.name}-http" }, var.tags)
  }
}