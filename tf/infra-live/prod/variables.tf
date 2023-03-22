variable "account_db_user" {
  description = "The database user for the account microservice"
  type        = string
}

variable "account_db_password" {
  description = "The database password for the account microservice"
  type        = string
}

variable "account_vault_user" {
  description = "The username to use for the Vault generic endpoint for the account microservice"
  type        = string
}

variable "account_vault_password" {
  description = "The password to use for the Vault generic endpoint for the account microservice"
  type        = string
}

variable "gateway_db_user" {
  description = "The database user for the gateway microservice"
  type        = string
}

variable "gateway_db_password" {
  description = "The database password for the gateway microservice"
  type        = string
}

variable "gateway_vault_user" {
  description = "The username to use for the Vault generic endpoint for the gateway microservice"
  type        = string
}

variable "gateway_vault_password" {
  description = "The password to use for the Vault generic endpoint for the gateway microservice"
  type        = string
}

variable "payment_db_user" {
  description = "The database user for the payment microservice"
  type        = string
}

variable "payment_db_password" {
  description = "The database password for the payment microservice"
  type        = string
}

variable "payment_vault_user" {
  description = "The username to use for the Vault generic endpoint for the payment microservice"
  type        = string
}

variable "payment_vault_password" {
  description = "The password to use for the Vault generic endpoint for the payment microservice"
  type        = string
}
