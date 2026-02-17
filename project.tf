resource "tfe_project" "vault_admin" {
  description  = "Collection of workspaces for administering Vault"
  name         = "SB Vault Lab"
  organization = "philbrook"
}

# These projects should probably be in another workspace / repo, but meh
resource "tfe_project" "aws_vault_lab" {
  description  = "Admin code for my AWS Vault Lab."
  name         = "AWS Vault Lab"
  organization = "philbrook"
}

resource "tfe_project" "aws_vault_hvd_lz" {
  description  = "Landing zone for HVD-aligned AWS vault onboarding."
  name         = "AWS Vault HVD"
  organization = "philbrook"
}

resource "tfe_project_settings" "aws_lab_settings" {
  project_id = tfe_project.aws_vault_lab.id

  default_execution_mode = "agent"
  default_agent_pool_id  = tfe_agent_pool.aws_vault_hvd.id
}
