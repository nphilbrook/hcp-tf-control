resource "tfe_workspace" "delightful_otter" {
  name                  = "aws-delightful-otter"
  project_id            = "prj-jwafYpMw2Nb6m2Zd"
  file_triggers_enabled = "false"
  vcs_repo {
    github_app_installation_id = "ghain-ieieBWKoaGhWE3rE"
    identifier                 = "nphilbrook/aws-probable-pancake"
  }
}

# Use the agent pool to reach Vault
resource "tfe_workspace_settings" "otter_settings" {
  workspace_id   = tfe_workspace.delightful_otter.id
  execution_mode = "agent"
  agent_pool_id  = tfe_agent_pool.aws.id
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
