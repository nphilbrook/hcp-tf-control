resource "tfe_variable_set" "aws_vault_hvd_onboarding" {
  name   = "Global Variables for AWS HVD Vault LZ Onboarding"
  global = false
}

resource "tfe_variable" "aws_hvd_enable_vault_provider_auth" {
  variable_set_id = tfe_variable_set.aws_vault_hvd_onboarding.id

  key      = "TFC_VAULT_PROVIDER_AUTH"
  value    = "false"
  category = "env"

  description = "Enable dynamic Vault provider auth"
}

resource "tfe_variable" "aws_hvd_vault_address" {
  variable_set_id = tfe_variable_set.aws_vault_hvd_onboarding.id

  key      = "TFC_VAULT_ADDR"
  value    = local.aws_hvd_vault_address
  category = "env"

  description = "Vault address (environment variable for dynamic auth)"
}

resource "tfe_variable" "aws_hvd_vault_address_default" {
  variable_set_id = tfe_variable_set.aws_vault_hvd_onboarding.id

  key      = "TFC_DEFAULT_VAULT_ADDR"
  value    = local.aws_hvd_vault_address
  category = "env"

  description = "Vault address (environment variable for dynamic auth)"
}

resource "tfe_variable" "aws_hvd_vault_address_provider" {
  variable_set_id = tfe_variable_set.aws_vault_hvd_onboarding.id

  key      = "VAULT_ADDR"
  value    = local.aws_hvd_vault_address
  category = "env"

  description = "Vault address (environment variable for provider config / static auth)"
}

# resource "tfe_variable" "vault_namespace" {
#   variable_set_id = 

#   key      = "TFC_VAULT_NAMESPACE"
#   value    = "admin/live/Cloud-Operations"
#   category = "env"

#   description = "Vault namespace"
# }

# resource "tfe_variable" "vault_namespace_default" {
#   variable_set_id = 

#   key      = "TFC_DEFAULT_VAULT_NAMESPACE"
#   value    = "admin/live/Cloud-Operations"
#   category = "env"

#   description = "Vault namespace"
# }


resource "tfe_project_settings" "aws_hvd_ls_settings" {
  project_id = tfe_project.aws_vault_hvd_lz.id

  default_execution_mode = "agent"
  default_agent_pool_id  = tfe_agent_pool.aws_vault_hvd.id
}

resource "tfe_project_variable_set" "aws_vault_hvd_onboarding" {
  project_id      = tfe_project.aws_vault_hvd_lz.id
  variable_set_id = tfe_variable_set.aws_vault_hvd_onboarding.id
}
