provider "kubernetes" {
  host                   = module.eks[0].cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks[0].cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.this.token
}

#Create Service Account
resource "kubernetes_service_account" "impersonator" {
  count           = var.enabled ? 1 : 0
  metadata {
    name      = "impersonator-sa"
    namespace = "identity"
  }
  depends_on = [null_resource.wait_for_eks]
}

#Create namespace
resource "kubernetes_namespace" "identity" {
  count           = var.enabled ? 1 : 0
  metadata {
    name = "identity"
  }
  depends_on = [null_resource.wait_for_eks]
}

#Bind cluster-admin permissions to the service account
resource "kubernetes_cluster_role_binding" "impersonator_sa_admin" {
  count           = var.enabled ? 1 : 0
  metadata {
    name = "impersonator-sa-admin"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.impersonate_user[count.index].metadata[0].name
  }
  subject {
    kind      = "ServiceAccount"
    name      = "impersonator-sa"
    namespace = "identity"
  }
  depends_on = [null_resource.wait_for_eks]
}

#Impersonator cluster role and cluster role binding
resource "kubernetes_cluster_role" "impersonate_user" {
  count           = var.enabled ? 1 : 0
  metadata {
    name = "impersonate-user"
  }

  rule {
    api_groups = [""]
    resources  = ["users", "groups", "serviceaccounts"]
    verbs      = ["impersonate"]
    resource_names = ["system:serviceaccount:identity:impersonator-sa"]
  }
  depends_on = [null_resource.wait_for_eks]
}

resource "kubernetes_cluster_role_binding" "impersonate_binding" {
  count           = var.enabled ? 1 : 0
  metadata {
    name = "impersonate-binding"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.impersonate_user[count.index].metadata[0].name
  }

  subject {
    kind      = "ServiceAccount"
    name      = "impersonator-sa"
    namespace = "identity"
  }
  depends_on = [null_resource.wait_for_eks]
}

#Disovery user for SDM
resource "kubernetes_cluster_role" "discovery" {
  count           = var.enabled ? 1 : 0
  metadata {
    name = "discovery"
  }

  rule {
    api_groups = [""]
    resources  = ["namespaces", "serviceaccounts"]
    verbs      = ["list", "get", "watch"]
  }
    rule {
    api_groups = ["rbac.authorization.k8s.io"]
    resources  = [
      "roles",
      "rolebindings",
      "clusterroles",
      "clusterrolebindings"
    ]
    verbs = ["list", "get", "watch"]
  }
  depends_on = [null_resource.wait_for_eks]
}

resource "kubernetes_cluster_role_binding" "discovery_binding" {
  count           = var.enabled ? 1 : 0
  metadata {
    name = "discovery-binding"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.discovery[count.index].metadata[0].name
  }
  subject {
    api_group = "rbac.authorization.k8s.io"
    kind      = "User"
    name      = "discovery"
  }
  depends_on = [null_resource.wait_for_eks]
}

#Health check user for SDM
resource "kubernetes_cluster_role" "healthcheck" {
  count           = var.enabled ? 1 : 0
  metadata {
    name = "healthcheck"
  }

  rule {
    api_groups = [""]
    resources  = ["pods"]
    verbs      = ["list", "get", "watch"]
  }
  depends_on = [null_resource.wait_for_eks]
}

resource "kubernetes_cluster_role_binding" "healthcheck_binding" {
  count           = var.enabled ? 1 : 0
  metadata {
    name = "healthcheck-binding"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.healthcheck[count.index].metadata[0].name
  }
  subject {
    api_group = "rbac.authorization.k8s.io"
    kind      = "User"
    name      = "healthcheck"
  }
  depends_on = [null_resource.wait_for_eks]
}

resource "null_resource" "wait_for_eks" {
  count           = var.enabled ? 1 : 0
  depends_on = [module.eks]

  provisioner "local-exec" {
    command = "aws eks wait cluster-active --name ${module.eks[0].cluster_name} --region ${var.aws_region}"
  }
}

# resource "null_resource" "wait_for_eks" {
#   provisioner "local-exec" {

#     command = <<EOT
#       for i in {1..60}; do
#         if ${module.eks.cluster_endpoint} > /dev/null 2>&1; then
#           echo "EKS API is available ${module.eks.cluster_endpoint}"
#           exit 0
#         fi
#         echo "Waiting for EKS cluster endpoint... ${module.eks.cluster_endpoint}"
#         sleep 10
#       done
#       echo "Timeout waiting for EKS API DNS"
#       exit 1
#     EOT
#   }

#   triggers = {
#     cluster = module.eks.cluster_name
#   }
# }
