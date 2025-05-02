resource "tfe_workspace" "hcp_vault_terraform" {
  description           = "Management of HCP Vault resources and the admin namespace of the Vault cluster"
  file_triggers_enabled = false
  name                  = "hcp-vault-terraform"
  organization          = "philbrook"
  project_id            = tfe_project.vault_admin.id
  queue_all_runs        = true
  terraform_version     = "1.11.1"
  vcs_repo {
    github_app_installation_id = "ghain-ieieBWKoaGhWE3rE"
    identifier                 = "nphilbrook/hcp-vault-terraform"
  }
}

# Share outputs from the hcp-vault-terraform workspace to *THIS* workspace
# So we can grab the Vault URL for dynamic auth configuration on other namespaces
resource "tfe_workspace_settings" "hcp_vault_tf_settings" {
  workspace_id = tfe_workspace.hcp_vault_terraform.id
  # ref data.tf for how this ID is sourced
  remote_state_consumer_ids = [data.tfe_workspace.this.id]
  execution_mode            = "agent"
  agent_pool_id             = tfe_agent_pool.aws.id
}

resource "tfe_variable" "hcp_ws_namespace" {
  workspace_id = tfe_workspace.hcp_vault_terraform.id

  key      = "TFC_VAULT_NAMESPACE"
  value    = "admin"
  category = "env"

  description = "Vault Namespace for this workspace"
}

resource "tfe_variable" "hcp_ws_vault_admin_run_role" {
  workspace_id = tfe_workspace.hcp_vault_terraform.id

  key      = "TFC_VAULT_RUN_ROLE"
  value    = "hcp-tf-admin"
  category = "env"

  description = "Vault JWT role for this workspace"
}

resource "tfe_variable" "hcp_workload_identity" {
  workspace_id = tfe_workspace.hcp_vault_terraform.id

  key      = "TFC_HCP_PROVIDER_AUTH"
  value    = "true"
  category = "env"

  description = "Enable HCP workload identity for this workspace"
}

resource "tfe_variable" "hcp_workload_identity_audience" {
  workspace_id = tfe_workspace.hcp_vault_terraform.id

  key      = "TFC_HCP_WORKLOAD_IDENTITY_AUDIENCE"
  value    = "hcp.workload.identity"
  category = "env"

  description = "HCP workload identity audience"
}

resource "tfe_variable" "hcp_workload_identity_resource" {
  workspace_id = tfe_workspace.hcp_vault_terraform.id

  key      = "TFC_HCP_RUN_PROVIDER_RESOURCE_NAME"
  value    = "iam/project/bbb3c5e5-262e-4171-8747-bf5da61f75d1/service-principal/hcp-vault-tf/workload-identity-provider/hcp-tf-dynamic-credentials"
  category = "env"

  description = "HCP workload identity resource name"
}


# ASSOCIATE Global values TO WORKSPACE
resource "tfe_workspace_variable_set" "global_hcp_vault_admin" {
  workspace_id    = tfe_workspace.hcp_vault_terraform.id
  variable_set_id = tfe_variable_set.global_vault_backed.id
}
