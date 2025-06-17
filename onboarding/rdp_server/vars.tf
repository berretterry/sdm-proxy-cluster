variable "name" {
  description = "The name of the project"
  type        = string
}
variable "vpc_id" {
  description = "vpc id of the project"
  type        = string
}
variable "tags" {
  description = "Tags to be applied to reasources created by this module"
  type        = map(string)
  default     = {}
}
variable "pc_worker_sg" {
  description = "proxy cluster security group id"
  type        = string
}
variable "subnet_id" {
  description = "Proxy Cluster Worker subnet id"
  type        = string
}
