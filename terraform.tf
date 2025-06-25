terraform {
  required_version = "~>1.11"

  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "~>0.64"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "~>4.8"
    }
  }
}
