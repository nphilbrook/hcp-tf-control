# Use the agent pool to reach Vault
resource "tfe_workspace_settings" "self_settings" {
  workspace_id   = data.tfe_workspace.this.id
  execution_mode = "agent"
  agent_pool_id  = tfe_agent_pool.aws.id
}
