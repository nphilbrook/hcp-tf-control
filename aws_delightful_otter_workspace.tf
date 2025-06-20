resource "tfe_workspace" "delightful_otter" {
  name                  = "aws-delightful-otter"
  project_id            = "prj-jwafYpMw2Nb6m2Zd"
  file_triggers_enabled = "false"
  vcs_repo {
    github_app_installation_id = "ghain-ieieBWKoaGhWE3rE"
    identifier                 = "nphilbrook/aws-probable-pancake"
  }
}

# just this workspace
resource "tfe_variable" "prefix" {
  workspace_id = tfe_workspace.delightful_otter.id

  key      = "prefix"
  value    = "otter"
  category = "terraform"

  description = "resource prefix for this workspace"
}

# ASSOCIATE TO WORKSPACE
# Global
resource "tfe_workspace_variable_set" "global_otter" {
  variable_set_id = tfe_variable_set.global_vault_backed.id
  workspace_id    = tfe_workspace.delightful_otter.id
}

# Common
resource "tfe_workspace_variable_set" "common_otter" {
  variable_set_id = tfe_variable_set.common_vault_backed_dynamic_aws_variable_set.id
  workspace_id    = tfe_workspace.delightful_otter.id
}

# workspace/etc specific
resource "tfe_workspace_variable_set" "delightful_otter" {
  variable_set_id = tfe_variable_set.cloud_ops_vault_backed_dynamic_aws_variable_set.id
  workspace_id    = tfe_workspace.delightful_otter.id
}
# END ASSOCIATE TO WORKSPACE
