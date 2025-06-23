resource "tfe_workspace" "probable_pancake" {
  name                  = "aws-probable-pancake"
  project_id            = "prj-jwafYpMw2Nb6m2Zd"
  file_triggers_enabled = "false"
  vcs_repo {
    github_app_installation_id = "ghain-ieieBWKoaGhWE3rE"
    identifier                 = "nphilbrook/aws-probable-pancake"
  }
}

# APP/WORKSPACE SPECIFIC
resource "tfe_variable_set" "cloud_ops_vault_backed_dynamic_aws_variable_set" {
  name   = "Cloud Operations Vault-Backed Dynamic AWS Credentials Variables"
  global = false
}

resource "tfe_variable" "vault_run_role" {
  variable_set_id = tfe_variable_set.cloud_ops_vault_backed_dynamic_aws_variable_set.id

  key      = "TFC_VAULT_RUN_ROLE"
  value    = "aws-dynamic-517068637116"
  category = "env"

  description = "Vault JWT role for this workspace"
}

resource "tfe_variable" "vault_aws_run_role" {
  variable_set_id = tfe_variable_set.cloud_ops_vault_backed_dynamic_aws_variable_set.id

  key      = "TFC_VAULT_BACKED_AWS_RUN_VAULT_ROLE"
  value    = "aws-dynamic-517068637116"
  category = "env"

  description = "Vault AWS role for this workspace"
}

resource "tfe_variable" "vault_aws_run_role_arn" {
  variable_set_id = tfe_variable_set.cloud_ops_vault_backed_dynamic_aws_variable_set.id

  key      = "TFC_VAULT_BACKED_AWS_RUN_ROLE_ARN"
  value    = "arn:aws:iam::517068637116:role/s3-full-access"
  category = "env"

  description = "AWS role ARN for this workspace"
}

resource "tfe_variable" "vault_namespace" {
  variable_set_id = tfe_variable_set.cloud_ops_vault_backed_dynamic_aws_variable_set.id

  key      = "TFC_VAULT_NAMESPACE"
  value    = "admin/live/Cloud-Operations"
  category = "env"

  description = "Vault namespace"
}

# For the 2nd AWS account
resource "tfe_variable" "enable_vault_backed_aws_provider_auth_doormat" {
  variable_set_id = tfe_variable_set.cloud_ops_vault_backed_dynamic_aws_variable_set.id

  key      = "TFC_VAULT_BACKED_AWS_AUTH_DOORMAT"
  value    = "true"
  category = "env"

  description = "Enable dynmaic AWS provider auth backed by Vault (Doormat alias)"
}

resource "tfe_variable" "aws_auth_type_doormat" {
  variable_set_id = tfe_variable_set.cloud_ops_vault_backed_dynamic_aws_variable_set.id

  key      = "TFC_VAULT_BACKED_AWS_AUTH_TYPE_DOORMAT"
  value    = "assumed_role"
  category = "env"

  description = "Use assumed_role auth type (Doormat alias)"
}

resource "tfe_variable" "vault_aws_run_role_doormat" {
  variable_set_id = tfe_variable_set.cloud_ops_vault_backed_dynamic_aws_variable_set.id

  key      = "TFC_VAULT_BACKED_AWS_RUN_VAULT_ROLE_DOORMAT"
  value    = "aws-dynamic"
  category = "env"

  description = "Vault AWS role for this workspace (Doormat)"
}

resource "tfe_variable" "vault_aws_run_role_arn_doormat" {
  variable_set_id = tfe_variable_set.cloud_ops_vault_backed_dynamic_aws_variable_set.id

  key      = "TFC_VAULT_BACKED_AWS_RUN_ROLE_ARN_DOORMAT"
  value    = "arn:aws:iam::590184029125:role/vault-assumed-role-credentials-demo"
  category = "env"

  description = "AWS role ARN for this workspace (Doormat)"
}

resource "tfe_variable" "vault_aws_path_doormat" {
  variable_set_id = tfe_variable_set.cloud_ops_vault_backed_dynamic_aws_variable_set.id

  key      = "TFC_VAULT_BACKED_AWS_MOUNT_PATH_DOORMAT"
  value    = "aws-doormat"
  category = "env"

  description = "The AWS engine path for the Doormat vault AWS provider alias"
}

resource "tfe_variable" "vault_namespace_doormat" {
  variable_set_id = tfe_variable_set.cloud_ops_vault_backed_dynamic_aws_variable_set.id

  key      = "TFC_VAULT_NAMESPACE_DOORMAT"
  value    = "admin/live/Cloud-Operations"
  category = "env"

  description = "Vault namespace"
}
# End 2nd AWS account

# END APP/WORKSPACE SPECIFIC

# ASSOCIATE TO WORKSPACE
# Global
resource "tfe_workspace_variable_set" "global" {
  variable_set_id = tfe_variable_set.global_vault_backed.id
  workspace_id    = tfe_workspace.probable_pancake.id
}

# Common
resource "tfe_workspace_variable_set" "common" {
  variable_set_id = tfe_variable_set.common_vault_backed_dynamic_aws_variable_set.id
  workspace_id    = tfe_workspace.probable_pancake.id
}

# workspace specific
resource "tfe_workspace_variable_set" "probable_pancake" {
  variable_set_id = tfe_variable_set.cloud_ops_vault_backed_dynamic_aws_variable_set.id

  workspace_id = tfe_workspace.probable_pancake.id
}
# END ASSOCIATE TO WORKSPACE
