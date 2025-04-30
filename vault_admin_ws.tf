resource "tfe_workspace" "vault_admin" {
  for_each              = local.top_level_namespaces
  name                  = "vault-admin-terraform-${each.value}"
  project_id            = tfe_project.vault_admin.id
  file_triggers_enabled = "false"
  vcs_repo {
    github_app_installation_id = "ghain-ieieBWKoaGhWE3rE"
    identifier                 = "nphilbrook/vault-admin-terraform"
    branch                     = each.value == "testing" ? each.value : null
  }

}

# Use the agent pool to reach Vault
resource "tfe_workspace_settings" "settings" {
  for_each       = tfe_workspace.vault_admin
  workspace_id   = each.value.id
  execution_mode = "agent"
  agent_pool_id  = tfe_agent_pool.aws.id
}

resource "tfe_variable" "namespace" {
  for_each     = tfe_workspace.vault_admin
  workspace_id = each.value.id

  key      = "TFC_VAULT_NAMESPACE"
  value    = "admin/${each.key}"
  category = "env"

  description = "Vault Namespace for this workspace"
}

resource "tfe_variable" "vault_admin_run_role" {
  for_each     = tfe_workspace.vault_admin
  workspace_id = each.value.id

  key      = "TFC_VAULT_RUN_ROLE"
  value    = "hcp-tf-top-level"
  category = "env"

  description = "Vault JWT role for this workspace"
}

resource "tfe_variable" "vault_address_tf" {
  for_each     = tfe_workspace.vault_admin
  workspace_id = each.value.id

  key      = "vault_address"
  value    = local.vault_address
  category = "terraform"

  description = "Vault address (Terraform variable for SAML setup in workspace code)"
}

# ASSOCIATE Global values TO WORKSPACE
resource "tfe_workspace_variable_set" "global_vault_admin" {
  for_each        = tfe_workspace.vault_admin
  workspace_id    = each.value.id
  variable_set_id = tfe_variable_set.global_vault_backed.id
}
