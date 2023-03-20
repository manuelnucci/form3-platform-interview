variable "environment" {
  description = "The environment to deploy to"
  type        = string
}

variable "vault_audit_file_path" {
  description = "The path to the audit log file"
  type        = string
  default     = "/vault/logs/audit"
}

variable "vault_auth_backend_type" {
  description = "The type of auth backend to use"
  type        = string
  default     = "userpass"
}

variable "microservices_config" {
  description = "The configuration for the microservices"
  type = list(object({
    name = string
    vault_config = object({
      db_user           = string
      db_password       = string
      endpoint_password = string
    })
    container_config = object({
      container_name        = string
      image                 = string
      environment_variables = list(string)
      exposed_ports = object({
        internal_port = number
        external_port = number
      })
      advanced_networking = object({
        network_name = string
      })
    })
  }))
}

variable "frontend_config" {
  description = "The configuration for the frontend"
  type = object({
    name = string
    container_config = object({
      container_name        = string
      image                 = string
      environment_variables = list(string)
      exposed_ports = object({
        internal_port = number
        external_port = number
      })
      advanced_networking = object({
        network_name = string
      })
    })
  })
}
