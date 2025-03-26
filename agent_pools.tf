import {
  to = tfe_agent_pool.aws
  id = "apool-fXJebpvzkKGqaCqN"
}

resource "tfe_agent_pool" "aws" {
  name                = "bu-lab-usw2"
  organization        = "philbrook"
  organization_scoped = false
}
