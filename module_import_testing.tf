module "workspace_uno" {
  source  = "flowingis/workspace/tfe"
  version = "0.5.0"

  name         = "my-workspace-name"
  organization = local.organization
  description  = "Simple workspace"

  terraform_version = "1.11.4"
  execution_mode    = "local"

  tag_names = [
    "project:import",
    "environment:dev",
  ]
}

import {
  id = "ws-n18wShL8kuThNEox"
  to = module.workspace_dos.tfe_workspace.this
}

module "workspace_dos" {
  source  = "flowingis/workspace/tfe"
  version = "0.5.0"

  name         = "my-workspace-imported"
  organization = local.organization

  terraform_version = "1.11.4"
  execution_mode    = "local"
}
