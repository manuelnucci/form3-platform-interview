resource "vault_generic_secret" "db_credentials" {
  path = "secret/${var.environment}/${var.microservice_name}"

  data_json = <<-EOF
    {
      "db_user": "${var.db_user}",
      "db_password": "${var.db_password}"
    }
  EOF
}

resource "vault_policy" "db_credentials" {
  name = "${var.microservice_name}-${var.environment}}"

  policy = <<-EOF
    path "secret/data/${var.environment}/${var.microservice_name}" {
      capabilities = ["list", "read"]
    }
  EOF
}

resource "vault_generic_endpoint" "this" {
  path                 = "auth/${var.auth_backend_type}/users/${var.microservice_name}-${var.environment}"
  ignore_absent_fields = true

  data_json = <<-EOF
    {
      "policies": ["${vault_policy.db_credentials.name}"],
      "password": "${var.endpoint_password}"
    }
  EOF
}
