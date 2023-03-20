variable "account_db_user" {
  description = "The database user for the account microservice"
  type        = string
}

variable "account_db_password" {
  description = "The database password for the account microservice"
  type        = string
}

variable "account_endpoint_password" {
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

variable "gateway_endpoint_password" {
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

variable "payment_endpoint_password" {
  description = "The password to use for the Vault generic endpoint for the payment microservice"
  type        = string
}
