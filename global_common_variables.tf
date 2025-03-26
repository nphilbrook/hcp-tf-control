resource "tfe_variable_set" "global_vault_backed" {
  name   = "Common Vault-Backed Dynamic AWS Credentials Variables"
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
  value    = "https://vault-cluster-private-vault-e9bf486c.f4702644.z1.hashicorp.cloud:8200/"
  category = "env"

  description = "Vault address"
}

