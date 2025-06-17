module "infrastructure" {
  source                       = "./infrastructure"
  name                         = var.name
  aws_region                   = var.aws_region
  vpc_id                       = module.infrastructure.vpc_id
  tags                         = var.tags
  private_subnet_ids           = module.infrastructure.public_subnet_ids
  public_subnet_ids            = module.infrastructure.public_subnet_ids
  ingress_cidr_blocks          = var.ingress_cidr_blocks
  sdm_proxy_cluster_access_key = module.sdm.sdm_proxy_cluster_access_key
  sdm_proxy_cluster_secret_key = module.sdm.sdm_proxy_cluster_secret_key
}

module "sdm" {
  source           = "./sdm"
  name             = var.name
  nlb_address      = module.infrastructure.nlb_address
  tags             = var.tags
  ssh_hostname     = module.ssh_server.ssh_hostname
  proxy_cluster_id = module.sdm.proxy_cluster_id
  password         = module.database.password
  username         = module.database.username
  database         = module.database.database
  db_hostname      = module.database.db_hostname
}

# module "rdp_server" {
#   source           = "./rdp_server"
#   name             = var.name
#   subnet_ids        = module.infrastructure.private_subnet_ids
#   vpc_id           = module.infrastructure.vpc_id
#   rdp_hostname     = module.rdp_server.hostname
# }

module "ssh_server" {
  source           = "./ssh_server"
  name             = var.name
  ssh_pubkey       = data.sdm_ssh_ca_pubkey.this_key.public_key
  pc_worker_sg     = module.infrastructure.worker_security_group_id
  subnet_id        = module.infrastructure.private_subnet_ids[0]
  vpc_id           = module.infrastructure.vpc_id
  ssh_hostname     = module.ssh_server.ssh_hostname
}

# module "eks" {
#   source                   = "./eks"
#   name                     = var.name
#   subnet_ids               = module.infrastructure.private_subnet_ids
#   vpc_id                   = module.infrastructure.vpc_id
#   worker_role_arn          = module.infrastructure.worker_role_arn
#   worker_security_group_id = module.infrastructure.worker_security_group_id
#   eks_endpoint             = module.eks.endpoint
# }

module "database" {
  source            = "./database"
  name              = var.name
  pc_worker_sg      = module.infrastructure.worker_security_group_id
  subnet_ids        = module.infrastructure.private_subnet_ids
  vpc_id            = module.infrastructure.vpc_id
}


