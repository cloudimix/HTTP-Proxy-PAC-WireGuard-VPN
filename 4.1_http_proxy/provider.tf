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
  auth                = var.oci_auth
  config_file_profile = var.oci_config_file_profile
}
