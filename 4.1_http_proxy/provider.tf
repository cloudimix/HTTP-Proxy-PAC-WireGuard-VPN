
terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
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
