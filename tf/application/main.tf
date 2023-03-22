resource "vault_audit" "this" {
  type = "file"

  options = {
    file_path = var.vault_audit_file_path
  }
}

resource "vault_auth_backend" "this" {
  type = var.vault_auth_backend_type
}

module "microservices_db_credentials" {
  source   = "./vault"
  for_each = { for ms in var.microservices_config : ms.name => ms }

  environment       = var.environment
  auth_backend_type = vault_auth_backend.this.type
  microservice_name = each.value.name
  db_user           = each.value.vault_config.db_user
  db_password       = each.value.vault_config.db_password
  endpoint_password = each.value.vault_config.endpoint_password
}

module "microservices_containers" {
  source   = "./docker"
  for_each = { for ms in var.microservices_config : ms.name => ms }

  container_name        = each.value.container_config.container_name
  image                 = each.value.container_config.image
  environment_variables = each.value.container_config.environment_variables
  exposed_ports         = each.value.container_config.exposed_ports != null
  internal_port         = try(each.value.container_config.exposed_ports.internal_port, null)
  external_port         = try(each.value.container_config.exposed_ports.external_port, null)
  advanced_networking   = each.value.container_config.advanced_networking != null
  network_name          = try(each.value.container_config.advanced_networking.network_name, null)
}

module "frontend_container" {
  source = "./docker"

  container_name        = var.frontend_config.container_config.container_name
  image                 = var.frontend_config.container_config.image
  environment_variables = var.frontend_config.container_config.environment_variables
  exposed_ports         = var.frontend_config.container_config.exposed_ports != null
  internal_port         = try(var.frontend_config.container_config.exposed_ports.internal_port, null)
  external_port         = try(var.frontend_config.container_config.exposed_ports.external_port, null)
  advanced_networking   = var.frontend_config.container_config.advanced_networking != null
  network_name          = try(var.frontend_config.container_config.advanced_networking.network_name, null)
}
