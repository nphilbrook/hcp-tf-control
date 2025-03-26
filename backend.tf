terraform {
  cloud {
    organization = "bankunited-core"

    workspaces {
      name    = "hcp-tf-control"
      project = "Vault Admin"
    }
  }
}
