variable "instance-AMD_source_image_id" { default = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaahwtpw63fcu6jmiyjxywh2lg7wto5wpcbsu4kvfxaxfuxrqj7ciqa" }
variable "instance-ARM_source_image_id" { default = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaabh7a24rl4qxunwziscawa4k65ar7ktdbbt4yf74hvcp7zipharhq" }
variable "region" { default = "eu-frankfurt-1" }
variable "compartment_ocid" { default = "ocid1.tenancy.oc1..aaaaaaaahtactnba6jjmlnozlgyi3nkzupcl2hu6ymsuw6bplpq3rjrsmlqa" }
variable "tenancy_ocid" { default = "ocid1.tenancy.oc1..aaaaaaaahtactnba6jjmlnozlgyi3nkzupcl2hu6ymsuw6bplpq3rjrsmlqa" }
variable "id_rsa" { default = "~/.ssh/id_rsa.pub" }
variable "oci_auth" { default = "SecurityToken" }
variable "oci_config_file_profile" { default = "terraform" }
