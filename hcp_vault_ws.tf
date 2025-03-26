import {
  to = tfe_workspace.hcp_vault_terraform
  id = "ws-pTCEqUgg62CP5Z4b"
}

import {
  to = tfe_project.vault_admin
  id = "prj-jwafYpMw2Nb6m2Zd"
}

resource "tfe_project" "vault_admin" {
  description  = "Collection of workspaces for administering Vault"
  name         = "SB Vault Lab"
  organization = "philbrook"
}

resource "tfe_workspace" "hcp_vault_terraform" {
  description           = "Management of HCP Vault resources and the admin namespace of the Vault cluster"
  file_triggers_enabled = false
  name                  = "hcp-vault-terraform"
  organization          = "philbrook"
  project_id            = tfe_project.vault_admin.id
  queue_all_runs        = true
  terraform_version     = "1.11.1"
  vcs_repo {
    github_app_installation_id = "ghain-ieieBWKoaGhWE3rE"
    identifier                 = "nphilbrook/hcp-vault-terraform"
  }
}

resource "tfe_variable" "hcp_ws_namespace" {
  workspace_id = tfe_workspace.hcp_vault_terraform.id
  description  = "Vault Namespace for this workspace"
  key          = "TFC_VAULT_NAMESPACE"
  value        = "admin"
  category     = "env"
}

resource "tfe_variable" "hcp_ws_vault_admin_run_role" {
  workspace_id = tfe_workspace.hcp_vault_terraform.id
  key          = "TFC_VAULT_RUN_ROLE"
  value        = "hcp-tf-admin"
  category     = "env"
  description  = "Vault JWT role for this workspace"
}


# ASSOCIATE Global values TO WORKSPACE
resource "tfe_workspace_variable_set" "global_hcp_vault_admin" {
  workspace_id    = tfe_workspace.hcp_vault_terraform.id
  variable_set_id = tfe_variable_set.global_vault_backed.id
}
