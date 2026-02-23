resource "tfe_variable_set" "aws_vault_hvd_onboarding" {
  name   = "Shared Variables for AWS HVD Vault LZ Onboarding"
  global = false
}

resource "tfe_variable" "aws_ws_vault_lz_run_role" {
  variable_set_id = tfe_variable_set.aws_vault_hvd_onboarding.id

  key      = "TFC_VAULT_RUN_ROLE"
  value    = "hcp-tf-lz"
  category = "env"

  description = "Vault JWT role for this workspace"
}

resource "tfe_project_variable_set" "aws_vault_hvd_onboarding" {
  project_id      = tfe_project.aws_vault_hvd_lz.id
  variable_set_id = tfe_variable_set.aws_vault_hvd_onboarding.id
}

# ASSOCIATE Global values TO PROJECT
resource "tfe_project_variable_set" "global_aws_vault_lz" {
  project_id      = tfe_project.aws_vault_hvd_lz.id
  variable_set_id = tfe_variable_set.global_aws_vault_backed.id
}

# A team for admin'ing this project - mostly for AI agents
resource "tfe_team" "onboarding_admin" {
  name = "AWS HVD Vault LZ Onboarding Admins"
}

resource "tfe_team_project_access" "onboarding_admin_access" {
  team_id    = tfe_team.onboarding_admin.id
  project_id = tfe_project.aws_vault_hvd_lz.id

  access = "admin"
}
