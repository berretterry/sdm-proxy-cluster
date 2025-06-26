data "aws_caller_identity" "current" {}

data "aws_eks_cluster_auth" "this" {
  name = module.eks.cluster_name
}

data "aws_iam_roles" "this" {
  name_regex = "AWSReservedSSO_AdministratorAccess_.*"
}