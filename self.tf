# Use the agent pool to reach Vault
resource "tfe_workspace_settings" "self_settings" {
  workspace_id   = data.tfe_workspace.this.id
  execution_mode = "agent"
  agent_pool_id  = tfe_agent_pool.aws.id
}

resource "tfe_variable" "enable_vault_provider_auth_tfc_admin" {
  workspace_id = data.tfe_workspace.this.id

  key      = "TFC_VAULT_PROVIDER_AUTH"
  value    = "true"
  category = "env"

  description = "Enable dynmaic Vault provider auth"
}

resource "tfe_variable" "vault_address_tfc_admin" {
  workspace_id = data.tfe_workspace.this.id

  key      = "TFC_VAULT_ADDR"
  value    = local.vault_address
  category = "env"

  description = "Vault address (environemnt variable for dynamic auth)"
}

resource "tfe_variable" "namespace_tfc_admin" {
  workspace_id = data.tfe_workspace.this.id

  key      = "TFC_VAULT_NAMESPACE"
  value    = "admin/live/Cloud-Operations"
  category = "env"

  description = "Vault Namespace for this workspace"
}

resource "tfe_variable" "run_role_tfc_admin" {
  workspace_id = data.tfe_workspace.this.id

  key      = "TFC_VAULT_RUN_ROLE"
  value    = "tfc-workspace-admin"
  category = "env"

  description = "Vault JWT role for this workspace"
}
