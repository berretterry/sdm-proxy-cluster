resource "sdm_resource" "k8s_eks_data_eks" {
  amazon_eks_instance_profile {
    name         = "${var.name}-eks"
    cluster_name = module.eks.cluster_name

    proxy_cluster_id = var.proxy_cluster_id

    certificate_authority = base64decode(module.eks.cluster_certificate_authority_data)

    endpoint = split("//", module.eks.cluster_endpoint)[1]
    region   = split(".", module.eks.cluster_endpoint)[2]

    # When specified strongDM will inherit permissions from this role
    tags = merge({
      Name = "${var.name}-eks"
    }, var.tags)
  }
}