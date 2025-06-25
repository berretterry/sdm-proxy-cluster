output "eks_cluster_endpoint" {
  value       = module.eks[0].eks_cluster_endpoint
  description = "eks cluster endpoint"
}

