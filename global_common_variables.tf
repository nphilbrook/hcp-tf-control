resource "tfe_variable_set" "global_vault_backed" {
  name   = "Global Vault-Backed Dynamic AWS Credentials Variables"
  global = false
}

resource "tfe_variable" "enable_vault_provider_auth" {
  variable_set_id = tfe_variable_set.global_vault_backed.id

  key      = "TFC_VAULT_PROVIDER_AUTH"
  value    = "true"
  category = "env"

  description = "Enable dynmaic Vault provider auth"
}

resource "tfe_variable" "vault_address" {
  variable_set_id = tfe_variable_set.global_vault_backed.id

  key      = "TFC_VAULT_ADDR"
  value    = local.vault_address
  category = "env"

  description = "Vault address (environemnt variable for dynamic auth)"
}

resource "tfe_variable" "vault_address_default" {
  variable_set_id = tfe_variable_set.global_vault_backed.id

  key      = "TFC_DEFAULT_VAULT_ADDR"
  value    = local.vault_address
  category = "env"

  description = "Vault address (environemnt variable for dynamic auth)"
}
