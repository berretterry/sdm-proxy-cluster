module "strongdm_demo" {
  source = "./onboarding"

  # Tags will be added to strongDM and AWS resources.
  tags                    = {Name = "${name}"}

  # List of email addresses of existing StrongDM users who will receive access to all resources
  grant_to_existing_users = ["berret.terry+cssandbox@strongdm.com"]

  # Name will be added to resource names
  name                    = "bt-pc-demo"

  #AWS Region you want resources deployed in
  aws_region              = "us-west-2"

  #Comment this line out to create an rdp server
  create_rdp              = true

  #Comment this line out to create an ssh/web server
  create_ssh_web          = true

  #Comment this line out to create an eks cluster with discovery, impersonation, and identity alias
  create_eks              = true

  #Comment this line out to create a mysql rds database
  create_db               = true
}
