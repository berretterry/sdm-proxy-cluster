resource "aws_ssm_parameter" "secret_key" {
  name = "/strongdm/proxy-cluster/${var.name}/secret-key"
  type = "SecureString"

  value = var.sdm_proxy_cluster_secret_key

}