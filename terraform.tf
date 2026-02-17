terraform {
  required_version = "~>1.14"

  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "~>0.64"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "~>5.7"
    }
  }
}
