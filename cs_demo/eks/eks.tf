module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "20.37.1"
  cluster_name    = "${var.name}-eks"
  cluster_version = "1.32"
  subnet_ids      = var.subnet_ids
  vpc_id          = var.vpc_id

  tags = merge({ Name = "${var.name}-eks" }, var.tags)

  access_entries = {
    strongdm = {
      kubernetes_groups = []
      principal_arn     = var.eks_role_arn
      policy_associations = {
        admin = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSAdminPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    }
  }

  cluster_security_group_additional_rules = {
    strongdm = {
      description              = "Allow traffic from proxy workers to API endpoint"
      protocol                 = "tcp"
      from_port                = 443
      to_port                  = 443
      type                     = "ingress"
      source_security_group_id = var.pc_worker_sg
    }
  }
}