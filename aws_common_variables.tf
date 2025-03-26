# Runs with this variable set will be automatically authenticated
# to AWS with vault-backed dynamic credentials
resource "tfe_variable_set" "common_vault_backed_dynamic_aws_variable_set" {
  name   = "Common Vault-Backed Dynamic AWS Credentials Variables"
  global = false
}

resource "tfe_variable" "vault_namespace" {
  variable_set_id = tfe_variable_set.common_vault_backed_dynamic_aws_variable_set.id

  key = "TFC_VAULT_NAMESPACE"
  # TODO: move this once namespaces are designed and deployed
  value    = "admin"
  category = "env"

  description = "Vault namespace"
}

resource "tfe_variable" "enable_vault_backed_aws_provider_auth" {
  variable_set_id = tfe_variable_set.common_vault_backed_dynamic_aws_variable_set.id

  key      = "TFC_VAULT_BACKED_AWS_AUTH"
  value    = "true"
  category = "env"

  description = "Enable dynmaic AWS provider auth backed by Vault"
}

resource "tfe_variable" "aws_auth_type" {
  variable_set_id = tfe_variable_set.common_vault_backed_dynamic_aws_variable_set.id

  key      = "TFC_VAULT_BACKED_AWS_AUTH_TYPE"
  value    = "assumed_role"
  category = "env"

  description = "Use assumed_role auth type"
}
