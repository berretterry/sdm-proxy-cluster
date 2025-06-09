resource "sdm_node" "cs-proxy-cluster" {
  proxy_cluster {
    name    = "cs-proxy-cluster"
    address = "${aws_lb.this.dns_name}:443"
    tags = {
      owner = "bt-proxy-cluster"
    }
  }
}

resource "sdm_proxy_cluster_key" "this" {
  proxy_cluster_id = sdm_node.cs-proxy-cluster.id
}