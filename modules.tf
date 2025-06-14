module "infrastructure" {
  source                       = "./infrastructure"
  name                         = var.name
  vpc_id                       = module.infrastructure.vpc_id
  #ecs_cluster_name            = module.infrastructure.ecs_cluster_name
  private_subnet_ids           = module.infrastructure.public_subnet_ids
  public_subnet_ids            = module.infrastructure.public_subnet_ids
  ingress_cidr_blocks          = var.ingress_cidr_blocks
  sdm_proxy_cluster_access_key = module.sdm.sdm_proxy_cluster_access_key
  sdm_proxy_cluster_secret_key = module.sdm.sdm_proxy_cluster_secret_key
  #worker_role_arn             = module.infrastructure.worker_role_arn
  #worker_security_group_id    = module.infrastructure.worker_security_group_id
}

module "sdm" {
  source           = "./sdm"
  name             = var.name
  nlb_address      = local.nlb_address
  #vpc_id           = module.infrastructure.vpc_id
  #proxy_cluster_id = module.sdm.id
  #rdp_hostname     = module.rdp_server.hostname
  #ssh_hostname     = module.ssh_server.hostname
  #eks_endpoint     = module.eks.endpoint
  #db_endpoint      = module.database.endpoint
}

# module "rdp_server" {
#   source           = "./rdp_server"
#   name             = var.name
#   security_group   = module.infrastructure.worker_security_group_id
#   subnet_id        = module.infrastructure.private_subnet_ids[0]
#   vpc_id           = module.infrastructure.vpc.vpc_id
#   rdp_hostname     = module.rdp_server.hostname
# }

# module "ssh_server" {
#   source           = "./ssh_server"
#   name             = var.name
#   security_group   = module.infrastructure.worker_security_group_id
#   subnet_id        = module.infrastructure.private_subnet_ids[0]
#   vpc_id           = module.infrastructure.vpc.vpc_id
#   ssh_hostname     = module.ssh_server.hostname
# }

# module "eks" {
#   source                   = "./eks"
#   name                     = var.name
#   subnet_ids               = module.infrastructure.private_subnet_ids
#   vpc_id                   = module.infrastructure.vpc_id
#   worker_role_arn          = module.infrastructure.worker_role_arn
#   worker_security_group_id = module.infrastructure.worker_security_group_id
#   eks_endpoint             = module.eks.endpoint
# }

# module "database" {
#   source           = "./database"
#   name             = var.name
#   security_group   = module.infrastructure.worker_security_group_id
#   subnet_id        = module.infrastructure.private_subnet_ids[0]
#   vpc_id           = module.infrastructure.vpc.vpc_id
#   db_endpoint      = module.database.endpoint
# }


