resource "aws_ssm_parameter" "secret_key" {
  name = "/strongdm/proxy-cluster/${var.name}/secret-key"
  type = "SecureString"

  value = sdm_proxy_cluster_key.cs-proxy-cluster-key.secret_key

}