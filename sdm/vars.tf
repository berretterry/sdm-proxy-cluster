variable "name" {
  description = "This name is applied to resources where applicable, e.g. titles and tags."
  type        = string
  default     = "bt-pc-demo"
}

variable "nlb_address" {
  description = "This is the external dns of the nlb."
  type        = string
}