resource "tfe_project" "vault_admin" {
  description  = "Collection of workspaces for administering Vault"
  name         = "SB Vault Lab"
  organization = "philbrook"
}
