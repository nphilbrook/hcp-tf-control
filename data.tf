# Automatically provided from HCP Terraform, BUT ONLY if this is a root module
variable "TFC_WORKSPACE_SLUG" {
  type = string
}

locals {
  slug_parts = split("/", var.TFC_WORKSPACE_SLUG)
  org_name   = local.slug_parts[0]
  ws_name    = local.slug_parts[1]
}

# Get a reference to our *own* workspace ID
data "tfe_workspace" "this" {
  organization = local.org_name
  name         = local.ws_name
}

output "ws_id" {
  value = data.tfe_workspace.this.id
}
