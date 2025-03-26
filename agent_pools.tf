resource "tfe_agent_pool" "aws" {
  name                = "bu-lab-usw2"
  organization        = "philbrook"
  organization_scoped = true
}
