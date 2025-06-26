resource "tfe_workspace" "probable_pancake" {
  name                  = "aws-probable-pancake"
  project_id            = "prj-jwafYpMw2Nb6m2Zd"
  file_triggers_enabled = "false"
  vcs_repo {
    github_app_installation_id = "ghain-ieieBWKoaGhWE3rE"
    identifier                 = "nphilbrook/aws-probable-pancake"
  }
}

# ASSOCIATE TO WORKSPACE
# Global
resource "tfe_workspace_variable_set" "global" {
  variable_set_id = tfe_variable_set.global_vault_backed.id
  workspace_id    = tfe_workspace.probable_pancake.id
}
# END ASSOCIATE TO WORKSPACE

# Configure Vault AWS authentication for this workspace
module "probably_pancake_vault_aws_auth" {
  source  = "app.terraform.io/philbrook/tf-workspace-aws-auth/vault"
  version = "1.0.1"

  workspace_name  = tfe_workspace.probable_pancake.name
  workspace_id    = tfe_workspace.probable_pancake.id
  aws_account_ids = ["517068637116", "620929731891"]

  aws_iam_role_name = "s3-full-access"
  tf_organization   = "philbrook"
}
