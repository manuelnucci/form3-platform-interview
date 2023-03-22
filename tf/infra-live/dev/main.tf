locals {
  environment = "development"
}

module "sample_application" {
  source = "../../application"

  environment             = local.environment
  vault_audit_file_path   = "/vault/logs/audit"
  vault_auth_backend_type = "userpass"
  microservices_config = [
    {
      "name" : "account",
      "vault_config" : {
        "db_user" : "${var.account_db_user}}",
        "db_password" : "${var.account_db_password}",
        "endpoint_password" : "${var.account_vault_password}"
      },
      "container_config" : {
        "container_name" : "account_${local.environment}",
        "image" : "form3tech-oss/platformtest-account",
        "environment_variables" : [
          "ENVIRONMENT=${local.environment}",
          "VAULT_ADDR=http://vault-${local.environment}:8200",
          "VAULT_USERNAME=${var.account_vault_user}",
          "VAULT_PASSWORD=${var.account_vault_password}",
        ],
        "exposed_ports" : null,
        "advanced_networking" : {
          "network_name" : "development",
        }
      }
    },
    {
      "name" : "gateway",
      "vault_config" : {
        "db_user" : "${var.gateway_db_user}}}",
        "db_password" : "${var.gateway_db_password}",
        "endpoint_password" : "${var.gateway_vault_password}"
      },
      "container_config" : {
        "container_name" : "gateway_${local.environment}",
        "image" : "form3tech-oss/platformtest-gateway",
        "environment_variables" : [
          "ENVIRONMENT=${local.environment}",
          "VAULT_ADDR=http://vault-${local.environment}:8200",
          "VAULT_USERNAME=${var.gateway_vault_user}",
          "VAULT_PASSWORD=${var.gateway_vault_password}",
        ],
        "exposed_ports" : null,
        "advanced_networking" : {
          "network_name" : "development",
        }
      }
    },
    {
      "name" : "payment",
      "vault_config" : {
        "db_user" : "${var.payment_db_user}}}",
        "db_password" : "${var.payment_db_password}",
        "endpoint_password" : "${var.payment_vault_password}"
      },
      "container_config" : {
        "container_name" : "payment_${local.environment}",
        "image" : "form3tech-oss/platformtest-payment",
        "environment_variables" : [
          "ENVIRONMENT=${local.environment}",
          "VAULT_ADDR=http://vault-${local.environment}:8200",
          "VAULT_USERNAME=${var.payment_vault_user}",
          "VAULT_PASSWORD=${var.payment_vault_password}",
        ],
        "exposed_ports" : null,
        "advanced_networking" : {
          "network_name" : "development",
        }
      }
    }
  ]
  frontend_config = {
    "name" : "frontend",
    "container_config" : {
      "container_name" : "frontend_${local.environment}",
      "image" : "docker.io/nginx:latest",
      "environment_variables" : [],
      "exposed_ports" : {
        "internal_port" : 80,
        "external_port" : 4080,
      },
      "advanced_networking" : {
        "network_name" : "development",
      }
    }
  }
}
