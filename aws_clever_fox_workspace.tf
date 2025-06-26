
resource "tfe_workspace" "clever_fox" {
  name                  = "aws-clever-fox"
  project_id            = "prj-jwafYpMw2Nb6m2Zd"
  file_triggers_enabled = "false"
  vcs_repo {
    github_app_installation_id = "ghain-ieieBWKoaGhWE3rE"
    identifier                 = "nphilbrook/aws-clever-fox"
  }
}

# Use the agent pool to reach Vault
resource "tfe_workspace_settings" "fox_settings" {
  workspace_id   = tfe_workspace.clever_fox.id
  execution_mode = "agent"
  agent_pool_id  = tfe_agent_pool.aws.id
}

# just this workspace
resource "tfe_variable" "fox_prefix" {
  workspace_id = tfe_workspace.clever_fox.id

  key      = "prefix"
  value    = "fox"
  category = "terraform"

  description = "resource prefix for this workspace"
}

# ASSOCIATE TO WORKSPACE
# Global
resource "tfe_workspace_variable_set" "global_fox" {
  variable_set_id = tfe_variable_set.global_vault_backed.id
  workspace_id    = tfe_workspace.clever_fox.id
}
# END ASSOCIATE TO WORKSPACE

# Configure Vault AWS authentication for this workspace
module "clever_fox_vault_aws_auth" {
  source  = "app.terraform.io/philbrook/tf-workspace-aws-auth/vault"
  version = "1.0.0"

  workspace_name    = tfe_workspace.clever_fox.name
  workspace_id      = tfe_workspace.clever_fox.id
  aws_account_ids   = ["517068637116"]

  aws_iam_role_name = "s3-full-access"
  tf_organization   = "philbrook"
}
