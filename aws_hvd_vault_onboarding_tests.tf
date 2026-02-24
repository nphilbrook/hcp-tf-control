
# Per-example workspaces for terraform-vault-app-onboarding
resource "tfe_workspace" "vault_onboarding_basic" {
  name                  = "vault-onboarding-basic"
  project_id            = tfe_project.aws_vault_hvd_lz.id
  file_triggers_enabled = false
  force_delete          = true
  working_directory     = "examples/basic"

  vcs_repo {
    github_app_installation_id = "ghain-ieieBWKoaGhWE3rE"
    identifier                 = "nphilbrook/terraform-vault-app-onboarding"
  }
}

resource "tfe_workspace" "vault_onboarding_with_kv_policy" {
  name                  = "vault-onboarding-with-kv-policy"
  project_id            = tfe_project.aws_vault_hvd_lz.id
  file_triggers_enabled = false
  force_delete          = true
  working_directory     = "examples/with-kv-policy"

  vcs_repo {
    github_app_installation_id = "ghain-ieieBWKoaGhWE3rE"
    identifier                 = "nphilbrook/terraform-vault-app-onboarding"
  }
}
