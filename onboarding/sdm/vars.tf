variable "name" {
  description = "This name is applied to resources where applicable, e.g. titles and tags."
  type        = string
}
variable "existing_users" {
  type        = list(string)
  description = "A list of email addresses for existing accounts to be granted access to all resources."
  default = []
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
variable "db_hostname" {
  description = "hostname for the database server."
  type        = string
}
variable "db_password" {
  description = "password for mysql database server."
  type        = string
}
variable "db_username" {
  description = "username for mysql database server."
  type        = string
}
variable "database" {
  description = "mysql database name."
  type        = string
}
variable "rdp_username" {
  description = "username for rdp server."
  type        = string
}
variable "rdp_password" {
  description = "password for rdp server."
  type        = string
}
variable "rdp_private_key" {
  description = "private key for rdp server."
  type        = string
}
variable "rdp_hostname" {
  description = "hostname/ip for rdp server."
  type        = string
}

