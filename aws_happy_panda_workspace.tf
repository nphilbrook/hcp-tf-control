resource "tfe_workspace" "happy_panda" {
  name                  = "aws-happy-panda"
  project_id            = "prj-jwafYpMw2Nb6m2Zd"
  file_triggers_enabled = "false"
  vcs_repo {
    github_app_installation_id = "ghain-ieieBWKoaGhWE3rE"
    identifier                 = "nphilbrook/aws-probable-pancake"
  }
}

# Use the agent pool to reach Vault
resource "tfe_workspace_settings" "panda_settings" {
  workspace_id   = tfe_workspace.happy_panda.id
  execution_mode = "agent"
  agent_pool_id  = tfe_agent_pool.aws.id
}

# just this workspace
resource "tfe_variable" "panda_prefix" {
  workspace_id = tfe_workspace.happy_panda.id

  key      = "prefix"
  value    = "panda"
  category = "terraform"

  description = "resource prefix for this workspace"
}

# ASSOCIATE TO WORKSPACE
# Global
resource "tfe_workspace_variable_set" "global_panda" {
  variable_set_id = tfe_variable_set.global_vault_backed.id
  workspace_id    = tfe_workspace.happy_panda.id
}
# END ASSOCIATE TO WORKSPACE
