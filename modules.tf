module "infrastructure" {
  source           = "./infrastructure"
  name             = var.name
  vpc_id           = module.infra[0].vpc_id
  ecs_cluster_name = module.infra.ecs.ecs_cluster_name

  private_subnet_ids  = module.infrastructure.public_subnet_ids
  public_subnet_ids   = module.infra.vpc.public_subnets
  ingress_cidr_blocks = var.ingress_cidr_blocks

  subnet_ids               = local.private_subnet_ids
  vpc_id                   = module.infra.vpc.vpc_id
  tags                     = var.tags
  proxy_cluster_id         = try(module.proxy_cluster[0].id, "")
  worker_role_arn          = try(module.sdm_proxy_cluster[0].worker_role_arn, module.sdm_gateway[0].role_arn)
  worker_security_group_id = try(module.sdm_proxy_cluster[0].worker_security_group_id, module.sdm_gateway[0].gateway_security_group_id)

}

module "proxy_cluster" {
  source           = "./proxy_cluster"
  name             = var.name
  security_group   = try(module.sdm_proxy_cluster[0].worker_security_group_id, module.sdm_gateway[0].gateway_security_group_id)
  subnet_id        = local.private_subnet_ids[0]
  tags             = local.tags
  vpc_id           = module.infra.vpc.vpc_id
  proxy_cluster_id = try(module.proxy_cluster[0].id, "")
}

module "rdp_server" {
  source           = "./rdp_server"
  name             = var.name
  security_group   = try(module.sdm_proxy_cluster[0].worker_security_group_id, module.sdm_gateway[0].gateway_security_group_id)
  subnet_id        = local.private_subnet_ids[0]
  tags             = local.tags
  vpc_id           = module.infra.vpc.vpc_id
  proxy_cluster_id = try(module.proxy_cluster[0].id, "")
}

module "ssh_server" {
  source           = "./ssh_server"
  name             = var.name
  security_group   = try(module.sdm_proxy_cluster[0].worker_security_group_id, module.sdm_gateway[0].gateway_security_group_id)
  subnet_id        = local.private_subnet_ids[0]
  tags             = local.tags
  vpc_id           = module.infra.vpc.vpc_id
  proxy_cluster_id = try(module.sdm_proxy_cluster[0].id, "")
}


module "eks" {
  source                   = "./eks_cluster"
  name                     = var.name
  subnet_ids               = local.private_subnet_ids
  vpc_id                   = module.infra.vpc.vpc_id
  tags                     = local.tags
  proxy_cluster_id         = try(module.proxy_cluster[0].id, "")
  worker_role_arn          = try(module.sdm_proxy_cluster[0].worker_role_arn, module.sdm_gateway[0].role_arn)
  worker_security_group_id = try(module.sdm_proxy_cluster[0].worker_security_group_id, module.sdm_gateway[0].gateway_security_group_id)
}

module "database" {
  source           = "./database"
  name             = var.name
  vpc_id           = module.infra.vpc.vpc_id
  tags             = local.tags
  security_group   = try(module.sdm_proxy_cluster[0].worker_security_group_id, module.sdm_gateway[0].gateway_security_group_id)
  subnet_ids       = local.private_subnet_ids
  proxy_cluster_id = try(module.proxy_cluster[0].id, "")
}


