output "eks_cluster_endpoint" {
  value       = module.cs_demo.eks_cluster_endpoint
  description = "eks cluster endpoint"
}

output "eks_cluster_token" {
  value       = module.cs_demo.eks_cluster_token
  description = "eks cluster token"
  sensitive = true
}

output "eks_cluster_ca" {
  value       = module.cs_demo.eks_cluster_ca
  description = "eks cluster certificate"
}