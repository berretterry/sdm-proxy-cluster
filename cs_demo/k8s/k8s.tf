# provider "kubernetes" {
#   host                   = var.eks_cluster_endpoint
#   cluster_ca_certificate = base64decode(var.eks_cluster_ca)
#   token                  = data.aws_eks_cluster_auth.this.token
# }

#Create Service Account
resource "kubernetes_service_account" "impersonator" {
  metadata {
    name      = "impersonator-sa"
    namespace = "identity"
  }
}

#Create namespace
resource "kubernetes_namespace" "identity" {
  metadata {
    name = "identity"
  }
}

#Bind cluster-admin permissions to the service account
resource "kubernetes_cluster_role_binding" "impersonator_sa_admin" {
  metadata {
    name = "impersonator-sa-admin"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.impersonate_user.metadata[0].name
  }
  subject {
    kind      = "ServiceAccount"
    name      = "impersonator-sa"
    namespace = "identity"
  }
}

#Impersonator cluster role and cluster role binding
resource "kubernetes_cluster_role" "impersonate_user" {
  metadata {
    name = "impersonate-user"
  }

  rule {
    api_groups = [""]
    resources  = ["users", "groups", "serviceaccounts"]
    verbs      = ["impersonate"]
    resource_names = ["system:serviceaccount:identity:impersonator-sa"]
  }
}

resource "kubernetes_cluster_role_binding" "impersonate_binding" {
  metadata {
    name = "impersonate-binding"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.impersonate_user.metadata[0].name
  }

  subject {
    kind      = "ServiceAccount"
    name      = "impersonator-sa"
    namespace = "identity"
  }
}

#Disovery user for SDM
resource "kubernetes_cluster_role" "discovery" {
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
}

resource "kubernetes_cluster_role_binding" "discovery_binding" {
  metadata {
    name = "discovery-binding"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.discovery.metadata[0].name
  }
  subject {
    api_group = "rbac.authorization.k8s.io"
    kind      = "User"
    name      = "discovery"
  }
}

#Health check user for SDM
resource "kubernetes_cluster_role" "healthcheck" {
  metadata {
    name = "healthcheck"
  }

  rule {
    api_groups = [""]
    resources  = ["pods"]
    verbs      = ["list", "get", "watch"]
  }
}

resource "kubernetes_cluster_role_binding" "healthcheck_binding" {
  metadata {
    name = "healthcheck-binding"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.healthcheck.metadata[0].name
  }
  subject {
    api_group = "rbac.authorization.k8s.io"
    kind      = "User"
    name      = "healthcheck"
  }
}
