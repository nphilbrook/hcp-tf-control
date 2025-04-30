locals {
  vault_address = "https://vault-cluster-private-vault-e9bf486c.f4702644.z1.hashicorp.cloud:8200"
  # project_id    = "prj-jwafYpMw2Nb6m2Zd"
  top_level_namespaces = toset([
    "testing",
    "live"
  ])
  slug_parts = split("/", var.TFC_WORKSPACE_SLUG)
  org_name   = local.slug_parts[0]
  ws_name    = local.slug_parts[1]
}
