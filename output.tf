output "nlb_address" {
  value       = "${module.infrastructure.nlb_address}:443"
  description = "testing nlb"
}

# output "nlb_private_ips" {
#   value = module.infrastructure.nlb_private_ips
#   description = "nlb private ip addresses"
# }
