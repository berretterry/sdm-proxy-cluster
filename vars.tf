variable "aws_region" {
  description = "This is the region where your resources will be created"
  type = string
}

variable "name" {
  description = "This name is applied to resources where applicable, e.g. titles and tags."
  type        = string
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "This tags will be added to both AWS and strongDM resources"
}

variable "ingress_cidr_blocks" {
  description = "A list of CIDR blocks from which to allow ingress traffic"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}