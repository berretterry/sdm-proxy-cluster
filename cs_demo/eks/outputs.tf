output "eks_cluster_endpoint" {
  value       = module.eks[0].cluster_endpoint
  description = "eks cluster endpoint"
}

output "eks_cluster_ca" {
  value       = module.eks[0].cluster_certificate_authority_data
  description = "eks cluster certificate"
}

output "eks_cluster_token" {
  value       = data.aws_eks_cluster_auth.this.token
  description = "eks cluster token"
}

output "eks_cluster_name" {
  value = module.eks[0].cluster_name
}


