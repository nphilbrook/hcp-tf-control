terraform {
  cloud {
    organization = "philbrook"

    workspaces {
      name    = "hcp-tf-control"
      project = "SB Vault Lab"
    }
  }
}
