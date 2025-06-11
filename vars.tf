variable "aws_region" {
  type = string
  default = "us-west-2"
}

variable "name" {
  description = "This name is applied to resources where applicable, e.g. titles and tags."
  type        = string
  default     = "bt-pc-demo"
}

variable "tags" {
  description = "global tags"
  type        = string
  default     = "bt-pc-demo"
}

variable "ingress_cidr_blocks" {
  description = "A list of CIDR blocks from which to allow ingress traffic"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}