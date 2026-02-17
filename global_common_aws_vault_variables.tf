resource "tfe_variable_set" "global_aws_vault_backed" {
  name   = "Global Vault-Backed Dynamic Credentials Variables (AWS Cluster)"
  global = false
}

resource "tfe_variable" "enable_vault_provider_auth_aws" {
  variable_set_id = tfe_variable_set.global_aws_vault_backed.id

  key      = "TFC_VAULT_PROVIDER_AUTH"
  value    = "true"
  category = "env"

  description = "Enable dynmaic Vault provider auth"
}

resource "tfe_variable" "vault_address_aws" {
  variable_set_id = tfe_variable_set.global_aws_vault_backed.id

  key      = "TFC_VAULT_ADDR"
  value    = local.aws_hvd_vault_address
  category = "env"

  description = "Vault address (environment variable for dynamic auth)"
}

# If we get into aliass / multiple configs
# resource "tfe_variable" "vault_address_default" {
#   variable_set_id = tfe_variable_set.global_aws_vault_backed.id

#   key      = "TFC_DEFAULT_VAULT_ADDR"
#   value    = local.aws_hvd_vault_address
#   category = "env"

#   description = "Vault address (environment variable for dynamic auth)"
# }

# resource "tfe_variable" "vault_namespace" {
#   variable_set_id = tfe_variable_set.global_aws_vault_backed.id

#   key      = "TFC_VAULT_NAMESPACE"
#   value    = "TBD"
#   category = "env"

#   description = "Vault namespace"
# }

# resource "tfe_variable" "vault_namespace_default" {
#   variable_set_id = tfe_variable_set.global_aws_vault_backed.id

#   key      = "TFC_DEFAULT_VAULT_NAMESPACE"
#   value    = "TBD"
#   category = "env"

#   description = "Vault namespace"
# }

# resource "tfe_variable" "enable_vault_backed_aws_provider_auth" {
#   variable_set_id = tfe_variable_set.global_aws_vault_backed.id

#   key      = "TFC_VAULT_BACKED_AWS_AUTH"
#   value    = "true"
#   category = "env"

#   description = "Enable dynmaic AWS provider auth backed by Vault"
# }

# resource "tfe_variable" "aws_auth_type" {
#   variable_set_id = tfe_variable_set.global_aws_vault_backed.id

#   key      = "TFC_VAULT_BACKED_AWS_AUTH_TYPE"
#   value    = "assumed_role"
#   category = "env"

#   description = "Use assumed_role auth type"
# }

# resource "tfe_variable" "aws_auth_type_default" {
#   variable_set_id = tfe_variable_set.global_aws_vault_backed.id

#   key      = "TFC_DEFAULT_VAULT_BACKED_AWS_AUTH_TYPE"
#   value    = "assumed_role"
#   category = "env"

#   description = "Use assumed_role auth type"
# }
