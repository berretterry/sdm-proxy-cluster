#ECS Cluster
resource "aws_ecs_cluster" "this" {
  name = "${var.name}-ecs"
}
