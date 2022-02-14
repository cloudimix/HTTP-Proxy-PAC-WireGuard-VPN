terraform {
  required_providers {
    oci = {
      source = "hashicorp/oci"
    }
  }
  cloud {
    organization = "dimi"
    workspaces {
      name = "testWS"
    }
  }
}

provider "oci" {
  region              = var.region
  auth                = "SecurityToken"
  config_file_profile = "terraform"
}
