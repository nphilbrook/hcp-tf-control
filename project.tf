resource "tfe_project" "vault_admin" {
  description  = "Collection of workspaces for administering Vault"
  name         = "SB Vault Lab"
  organization = "philbrook"
}

resource "tfe_project" "aws_vault_hvd_lz" {
  description  = "Landing zone for HVD-aligned AWS vault onboarding."
  name         = "AWS Vault HVD"
  organization = "philbrook"
}
