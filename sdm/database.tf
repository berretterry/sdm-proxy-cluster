resource "sdm_resource" "mysql_admin" {
  mysql {
    name     = "${var.name}-mysql-admin"
    hostname = var.db_hostname
    database = var.database
    username = var.username
    password = var.password
    port     = 3306

    proxy_cluster_id = var.proxy_cluster_id

    tags = merge({ Name = "${var.name}-mysql-admin" }, var.tags)
  }
}
resource "sdm_resource" "mysql_ro" {
  mysql {
    name     = "${var.name}-mysql-replica-read-only"
    hostname = var.db_hostname
    database = var.database
    username = var.username
    password = var.password
    port     = 3306

    proxy_cluster_id = var.proxy_cluster_id

    tags = merge({
      Name               = "${var.name}-mysql-ro",
      ReadOnlyOnboarding = "true"
    }, var.tags)
  }
}