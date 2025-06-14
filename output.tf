output "nlb_address" {
  value       = "${module.infrastructure.nlb_address}:443"
  description = "testing nlb"
}