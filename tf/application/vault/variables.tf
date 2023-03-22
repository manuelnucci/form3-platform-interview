variable "environment" {
  description = "The environment to deploy to"
  type        = string
}

variable "microservice_name" {
  description = "The name of the microservice"
  type        = string
}

variable "auth_backend_type" {
  description = "The type of auth backend to use"
  type        = string
  default     = "userpass"
}

variable "db_user" {
  description = "The database user"
  type        = string
  default     = "account"
}

variable "db_password" {
  description = "The database password"
  type        = string
}

variable "endpoint_password" {
  description = "The password to use for the Vault generic endpoint"
  type        = string
}

