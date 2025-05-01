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
