resource "aws_ecs_task_definition" "this_bridge" {
  family                   = "sdm-proxy-bridge"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 2048
  memory                   = 4096
  execution_role_arn       = aws_iam_role.this_task_execution.arn
  task_role_arn            = aws_iam_role.this_task.arn
  container_definitions    = jsonencode([
      {
        name                          = "bridge"
        image                         = "public.ecr.aws/strongdm/relay"
        essential                     = true
        networkMode                   = "awsvpc"
        environment = [
        {
          name  = "SDM_DOCKERIZED"
          value = "true"
        },
        {
          name  = "SDM_BIND_ADDRESS"
          value = "8443"
        },
        {
          name  = "SDM_BRIDGE"
          value = "local"
        },
        {
          name  = "SDM_PROXY_CLUSTER_ACCESS_KEY"
          value = sdm_proxy_cluster_key.this.id
        },
      ]
      secrets = [
        {
          name      = "SDM_PROXY_CLUSTER_SECRET_KEY"
          valueFrom = aws_ssm_parameter.secret_key.arn
        },
      ]
        portMappings = [{
          protocol      = "tcp"
          containerPort = 8443
        }]
      }
    ]
  )
}

resource "aws_ecs_task_definition" "this_worker" {
  family                   = "sdm-proxy-worker"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 2048
  memory                   = 4096
  execution_role_arn       = aws_iam_role.this_task_execution.arn
  task_role_arn            = aws_iam_role.this_task.arn
  container_definitions    = jsonencode([
      {
        name                          = "worker"
        image                         = "public.ecr.aws/strongdm/relay"
        essential                     = true
        networkMode                   = "awsvpc"
        environment = [
        {
          name  = "SDM_DOCKERIZED"
          value = "true"
        },
        {
          name  = "SDM_BIND_ADDRESS"
          value = "8443"
        },
         {
          name  = "SDM_BRIDGE"
          value = ""
        },
        {
          name  = "SDM_PROXY_CLUSTER_ACCESS_KEY"
          value = sdm_proxy_cluster_key.this.id
        },
      ]
      secrets = [
        {
          name      = "SDM_PROXY_CLUSTER_SECRET_KEY"
          valueFrom = aws_ssm_parameter.secret_key.arn
        },
      ]
        portMappings = [{
          protocol      = "tcp"
          containerPort = 8443
        }]
      }
    ]
  )
}