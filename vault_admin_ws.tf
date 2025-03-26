resource "tfe_workspace" "vault_admin" {
  for_each              = local.top_level_namespaces
  name                  = "vault-admin-terraform-${each.value}"
  project_id            = local.project_id
  file_triggers_enabled = "false"
  vcs_repo {
    github_app_installation_id = "ghain-ieieBWKoaGhWE3rE"
    identifier                 = "nphilbrook/vault-admin-terraform"
    branch                     = each.value == "testing" ? each.value : null
  }
}

resource "tfe_variable" "namespace" {
  for_each     = tfe_workspace.vault_admin
  workspace_id = each.value.id

  key      = "VAULT_NAMESPACE"
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

# ASSOCIATE Global values TO WORKSPACE
resource "tfe_workspace_variable_set" "global_vault_admin" {
  for_each        = tfe_workspace.vault_admin
  workspace_id    = each.value.id
  variable_set_id = tfe_variable_set.global_vault_backed.id
}
