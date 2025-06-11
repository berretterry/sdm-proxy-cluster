#ECS Cluster
resource "aws_ecs_cluster" "this" {
  name = "bt-proxy-cluster-ecs"
}
