variable "name" {
  description = "This name is applied to resources where applicable, e.g. titles and tags."
  type        = string
}

variable "nlb_address" {
  description = "This is the external dns of the nlb."
  type        = string
}

variable "tags" {
  description = "Tags to be applied to reasources created by this module"
  type        = map(string)
  default     = {}
}
variable "proxy_cluster_id" {
  description = "sdm proxy cluster id."
  type        = string
}
variable "ssh_hostname" {
  description = "hostname for the ssh web server."
  type        = string
}