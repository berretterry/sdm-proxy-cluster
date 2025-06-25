output "eks_cluster_endpoint" {
  value       = module.eks.eks_cluster_endpoint
  description = "eks cluster endpoint"
}

output "eks_cluster_token" {
  value       = module.eks.eks_cluster_token
  description = "eks cluster token"
}

output "eks_cluster_ca" {
  value       = module.eks.eks_cluster_ca
  description = "eks cluster certificate"
}
