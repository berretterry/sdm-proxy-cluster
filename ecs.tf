#ECS Cluster
resource "aws_ecs_cluster" "this" {
  name = "proxy-cluster-ecs"
}
