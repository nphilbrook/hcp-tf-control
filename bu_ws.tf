resource "tfe_workspace" "cloud_ops_mgmt" {
  name                  = "vault-Cloud-Operations-terraform"
  project_id            = local.project_id
  file_triggers_enabled = "false"
  vcs_repo {
    github_app_installation_id = "ghain-ieieBWKoaGhWE3rE"
    identifier                 = "nphilbrook/vault-Cloud-Operations-terraform"
  }

}

# Use the agent pool to reach Vault
resource "tfe_workspace_settings" "co_settings" {
  workspace_id   = tfe_workspace.cloud_ops_mgmt.id
  execution_mode = "agent"
  agent_pool_id  = tfe_agent_pool.aws.id
}

resource "tfe_variable" "co_namespace" {
  workspace_id = tfe_workspace.cloud_ops_mgmt.id

  key      = "TFC_VAULT_NAMESPACE"
  value    = "admin/live/Cloud-Operations"
  category = "env"

  description = "Vault Namespace for this workspace"
}

resource "tfe_variable" "co_vault_admin_run_role" {
  workspace_id = tfe_workspace.cloud_ops_mgmt.id

  key      = "TFC_VAULT_RUN_ROLE"
  value    = "hcp-tf-management"
  category = "env"

  description = "Vault JWT role for this workspace"
}

# ASSOCIATE Global values TO WORKSPACE
resource "tfe_workspace_variable_set" "co_global_vault_admin" {
  workspace_id    = tfe_workspace.cloud_ops_mgmt.id
  variable_set_id = tfe_variable_set.global_vault_backed.id
}
