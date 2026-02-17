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

resource "tfe_project_settings" "aws_hvd_ls_settings" {
  project_id = tfe_project.aws_vault_hvd_lz.id

  default_execution_mode = "agent"
  default_agent_pool_id  = tfe_agent_pool.aws_vault_hvd.id
}

# ASSOCIATE Global values TO PROJECT
resource "tfe_project_variable_set" "global_aws_vault_lz" {
  project_id      = tfe_project.aws_vault_hvd_lz.id
  variable_set_id = tfe_variable_set.global_aws_vault_backed.id
}
