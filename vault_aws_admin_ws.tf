resource "tfe_workspace" "vault_aws_terraform" {
  description           = "Management of Vault resources on my AWS Lab vault cluster"
  file_triggers_enabled = false
  name                  = "vault-aws-admin-terraform"
  organization          = "philbrook"
  project_id            = tfe_project.aws_vault_lab.id
  queue_all_runs        = true
  terraform_version     = "1.14.5"
  vcs_repo {
    github_app_installation_id = "ghain-ieieBWKoaGhWE3rE"
    identifier                 = "nphilbrook/vault-aws-admin-terraform"
  }
}

# Working in root for now
# resource "tfe_variable" "aws_ws_namespace" {
#   workspace_id = tfe_workspace.vault_aws_terraform.id

#   key      = "TFC_VAULT_NAMESPACE"
#   value    = "admin"
#   category = "env"

#   description = "Vault Namespace for this workspace"
# }

resource "tfe_variable" "aws_ws_vault_admin_run_role" {
  workspace_id = tfe_workspace.vault_aws_terraform.id

  key      = "TFC_VAULT_RUN_ROLE"
  value    = "hcp-tf-admin"
  category = "env"

  description = "Vault JWT role for this workspace"
}

# ASSOCIATE Global values TO WORKSPACE
resource "tfe_workspace_variable_set" "global_aws_vault_admin" {
  workspace_id    = tfe_workspace.vault_aws_terraform.id
  variable_set_id = tfe_variable_set.global_aws_vault_backed.id
}
