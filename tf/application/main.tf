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
  count  = length(var.microservices_config)
  source = "./vault"

  environment       = var.environment
  auth_backend_type = vault_auth_backend.this.type
  microservice_name = var.microservices_config[count.index].name
  db_user           = var.microservices_config[count.index].vault_config.db_user
  db_password       = var.microservices_config[count.index].vault_config.db_password
  endpoint_password = var.microservices_config[count.index].vault_config.endpoint_password
}

module "microservices_containers" {
  count  = length(var.microservices_config)
  source = "./docker"

  container_name        = var.microservices_config[count.index].name
  image                 = var.microservices_config[count.index].container_config.image
  environment_variables = var.microservices_config[count.index].container_config.environment_variables
  exposed_ports         = var.microservices_config[count.index].container_config.exposed_ports != null
  internal_port         = var.microservices_config[count.index].container_config.exposed_ports.internal_port
  external_port         = var.microservices_config[count.index].container_config.exposed_ports.external_port
  advanced_networking   = var.microservices_config[count.index].container_config.advanced_networking != null
  network_name          = var.microservices_config[count.index].container_config.advanced_networking.network_name
}

module "frontend_container" {
  source = "./docker"

  container_name        = var.frontend_config.container_config.container_name
  image                 = var.frontend_config.container_config.image
  environment_variables = var.frontend_config.container_config.environment_variables
  exposed_ports         = var.frontend_config.container_config.exposed_ports != null
  internal_port         = var.frontend_config.container_config.exposed_ports.internal_port
  external_port         = var.frontend_config.container_config.exposed_ports.external_port
  advanced_networking   = var.frontend_config.container_config.advanced_networking != null
  network_name          = var.frontend_config.container_config.advanced_networking.network_name
}
