resource "tfe_agent_pool" "aws" {
  name                = "bu-lab-usw2"
  organization        = "philbrook"
  organization_scoped = true
}

resource "tfe_agent_pool" "aws_vault_hvd" {
  name                = "aws-vault-hvd"
  organization        = "philbrook"
  organization_scoped = false
}
