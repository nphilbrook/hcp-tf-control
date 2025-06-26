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

# Configure Vault AWS authentication for this workspace
module "otter_vault_aws_auth" {
  source  = "app.terraform.io/philbrook/tf-workspace-aws-auth/vault"
  version = "1.0.2"

  workspace_name  = tfe_workspace.delightful_otter.name
  workspace_id    = tfe_workspace.delightful_otter.id
  aws_account_ids = ["517068637116", "620929731891"]

  aws_iam_role_name = "s3-full-access"
  tf_organization   = "philbrook"
}
