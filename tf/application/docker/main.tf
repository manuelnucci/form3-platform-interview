resource "docker_container" "this" {
  name  = var.container_name
  image = var.image
  env   = var.environment_variables

  dynamic "ports" {
    for_each = var.exposed_ports ? [1] : []

    content {
      internal = var.internal_port
      external = var.external_port
    }
  }

  dynamic "networks_advanced" {
    for_each = var.advanced_networking ? [1] : []

    content {
      name = var.network_name
    }
  }

  lifecycle {
    ignore_changes = all
  }
}
