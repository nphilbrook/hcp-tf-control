resource "tfe_workspace" "probable_pancake" {
  name                  = "aws-probable-pancake"
  project_id            = "prj-jwafYpMw2Nb6m2Zd"
  file_triggers_enabled = "false"
  vcs_repo {
    github_app_installation_id = "ghain-ieieBWKoaGhWE3rE"
    identifier                 = "nphilbrook/aws-probable-pancake"
  }
}

# APP/WORKSPACE SPECIFIC
resource "tfe_variable_set" "probable_pancake_vault_backed_dynamic_aws_variable_set" {
  name   = "Probable Pancake Vault-Backed Dynamic AWS Credentials Variables"
  global = false
}

resource "tfe_variable" "vault_run_role" {
  variable_set_id = tfe_variable_set.probable_pancake_vault_backed_dynamic_aws_variable_set.id

  key      = "TFC_VAULT_RUN_ROLE"
  value    = "hcp-tf-probable-pancake"
  category = "env"

  description = "Vault JWT role for this workspace"
}

resource "tfe_variable" "vault_aws_run_role" {
  variable_set_id = tfe_variable_set.probable_pancake_vault_backed_dynamic_aws_variable_set.id

  key      = "TFC_VAULT_BACKED_AWS_RUN_VAULT_ROLE"
  value    = "probable-pancake-tf"
  category = "env"

  description = "Vault AWS role for this workspace"
}

resource "tfe_variable" "vault_aws_run_role_arn" {
  variable_set_id = tfe_variable_set.probable_pancake_vault_backed_dynamic_aws_variable_set.id

  key      = "TFC_VAULT_BACKED_AWS_RUN_ROLE_ARN"
  value    = "arn:aws:iam::517068637116:role/s3-full-access"
  category = "env"

  description = "Vault AWS role for this workspace"
}

resource "tfe_variable" "vault_namespace" {
  variable_set_id = tfe_variable_set.probable_pancake_vault_backed_dynamic_aws_variable_set.id

  key      = "TFC_VAULT_NAMESPACE"
  value    = "admin/live/Cloud-Operatinos"
  category = "env"

  description = "Vault namespace"
}

# END APP/WORKSPACE SPECIFIC

# ASSOCIATE TO WORKSPACE
# Global
resource "tfe_workspace_variable_set" "global" {
  variable_set_id = tfe_variable_set.global_vault_backed.id
  workspace_id    = tfe_workspace.probable_pancake.id
}

# Common
resource "tfe_workspace_variable_set" "common" {
  variable_set_id = tfe_variable_set.common_vault_backed_dynamic_aws_variable_set.id
  workspace_id    = tfe_workspace.probable_pancake.id
}

# workspace specific
resource "tfe_workspace_variable_set" "probable_pancake" {
  variable_set_id = tfe_variable_set.probable_pancake_vault_backed_dynamic_aws_variable_set.id
  workspace_id    = tfe_workspace.probable_pancake.id
}
# END ASSOCIATE TO WORKSPACE
