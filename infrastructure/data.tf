data "aws_region" "current" {}

data "aws_availability_zones" "available" {
  state = "available"
}

# data "aws_network_interface" "nlb_interfaces" {
#   for_each = var.private_subnet_ids
#   filter {
#     name   = "description"
#     values = ["ELB ${aws_lb.this.arn_suffix}"]
#   }
#   filter {
#     name   = "subnet-id"
#     values = [each.value]
#   }
# }