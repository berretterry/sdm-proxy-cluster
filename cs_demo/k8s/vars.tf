variable "name" {
  description = "The name of the project"
  type        = string
}
# variable "vpc_id" {
#   description = "vpc id of the project"
#   type        = string
# }
variable "tags" {
  description = "Tags to be applied to reasources created by this module"
  type        = map(string)
  default     = {}
}

variable "aws_region" {
  description = "This is the region where your resources will be created"
  type = string
}
variable "eks_cluster_endpoint" {
  description = "This is the EKS Cluster endpoint"
  type = string
}

variable "eks_cluster_ca" {
  description = "This is the EKS Cluster Certificate Authority"
  type = string
}
variable "eks_cluster_name" {
  description = "EKS Cluster name"
  type = string
}