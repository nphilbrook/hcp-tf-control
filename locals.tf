data "tfe_outputs" "hcp_vault_tf" {
  organization = local.organization
  workspace    = "hcp-vault-terraform"
}

locals {
  organization = "philbrook"
  # vault_address = "https://vault-cluster-private-vault-e9bf486c.f4702644.z1.hashicorp.cloud:8200"
  vault_address       = data.tfe_outputs.hcp_vault_tf.nonsensitive_values.private_endpoint_url
  vault_proxy_address = data.tfe_outputs.hcp_vault_tf.nonsensitive_values.proxy_endpoint_url
  top_level_namespaces = toset([
    "testing",
    "live"
  ])

  aws_hvd_vault_address    = "https://vault.nick-philbrook.sbx.hashidemos.io:8200"
  aws_hvd_pr_vault_address = "https://vault-pr.nick-philbrook.sbx.hashidemos.io:8200"
}
