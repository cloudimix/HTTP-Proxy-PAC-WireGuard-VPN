resource "oci_core_instance" "instance-AMD" {
  count               = 1
  availability_domain = data.oci_identity_availability_domain.oVBc-EU-FRANKFURT-1-AD-2.name
  compartment_id      = var.compartment_ocid
  display_name        = " ${format("instance-AMD%02d", count.index + 1)}"
  create_vnic_details {
    assign_public_ip = "true"
    display_name     = "instance-AMD"
    subnet_id        = oci_core_subnet.Public_subnet.id
  }
  launch_options {
    boot_volume_type                    = "PARAVIRTUALIZED"
    firmware                            = "UEFI_64"
    is_consistent_volume_naming_enabled = "true"
    network_type                        = "PARAVIRTUALIZED"
    remote_data_volume_type             = "PARAVIRTUALIZED"
  }
  metadata = {
    "ssh_authorized_keys" = file(var.id_rsa)
  }
  shape = "VM.Standard.E2.1.Micro"
  source_details {
    boot_volume_size_in_gbs = "50"
    source_id               = var.instance-AMD_source_image_id
    source_type             = "image"
  }
  state = "RUNNING"
}



resource "oci_core_instance" "instance-ARM" {
  count               = 0
  availability_domain = data.oci_identity_availability_domain.oVBc-EU-FRANKFURT-1-AD-2.name
  compartment_id      = var.compartment_ocid
  display_name        = " ${format("instance-ARM%02d", count.index + 1)}"
  create_vnic_details {
    assign_public_ip = "true"
    display_name     = "instance-ARM"
    subnet_id        = oci_core_subnet.Public_subnet.id
  }
  launch_options {
    boot_volume_type                    = "PARAVIRTUALIZED"
    firmware                            = "UEFI_64"
    is_consistent_volume_naming_enabled = "true"
    network_type                        = "PARAVIRTUALIZED"
    remote_data_volume_type             = "PARAVIRTUALIZED"
  }
  metadata = {
    "ssh_authorized_keys" = file(var.id_rsa)
  }
  shape = "VM.Standard.A1.Flex"
  shape_config {
    baseline_ocpu_utilization = ""
    memory_in_gbs             = "1"
    ocpus                     = "1"
  }
  source_details {
    boot_volume_size_in_gbs = "50"
    source_id               = var.instance-ARM_source_image_id
    source_type             = "image"
  }
  state = "RUNNING"
}

resource "oci_core_internet_gateway" "MainIGW" {
  compartment_id = var.compartment_ocid
  display_name   = "MainIGW"
  enabled        = "true"
  vcn_id         = oci_core_vcn.MainVCN.id
}

resource "oci_core_subnet" "Public_subnet" {

  cidr_block                 = "10.0.0.0/24"
  compartment_id             = var.compartment_ocid
  display_name               = "Public_subnet"
  dns_label                  = "publicsubnet"
  prohibit_internet_ingress  = "false"
  prohibit_public_ip_on_vnic = "false"
  route_table_id             = oci_core_vcn.MainVCN.default_route_table_id
  security_list_ids = [
    oci_core_vcn.MainVCN.default_security_list_id,
  ]
  vcn_id = oci_core_vcn.MainVCN.id
}

resource "oci_core_vcn" "MainVCN" {

  cidr_blocks = [
    "10.0.0.0/16",
  ]
  compartment_id = var.compartment_ocid
  display_name   = "MainVCN"
  dns_label      = "mainvcn"
}

resource "oci_core_default_dhcp_options" "Default-DHCP-Options-for-MainVCN" {
  compartment_id             = var.compartment_ocid
  display_name               = "Default DHCP Options for MainVCN"
  domain_name_type           = "CUSTOM_DOMAIN"
  manage_default_resource_id = oci_core_vcn.MainVCN.default_dhcp_options_id
  options {
    custom_dns_servers = [
    ]
    server_type = "VcnLocalPlusInternet"
    type        = "DomainNameServer"
  }
  options {
    search_domain_names = [
      "mainvcn.oraclevcn.com",
    ]
    type = "SearchDomain"
  }
}

resource "oci_core_default_route_table" "Default-Route-Table-for-MainVCN" {
  compartment_id             = var.compartment_ocid
  display_name               = "Default Route Table for MainVCN"
  manage_default_resource_id = oci_core_vcn.MainVCN.default_route_table_id
  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.MainIGW.id
  }
}

resource "oci_core_default_security_list" "Default-Security-List-for-MainVCN" {
  compartment_id = var.compartment_ocid
  display_name   = "Default Security List for MainVCN"
  egress_security_rules {
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    protocol         = "all"
    stateless        = "false"
  }
  ingress_security_rules {
    icmp_options {
      code = "4"
      type = "3"
    }
    protocol    = "1"
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    stateless   = "false"
  }
  ingress_security_rules {
    description = "https"
    protocol    = "6"
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    stateless   = "false"
    tcp_options {
      max = "443"
      min = "443"
    }
  }
  ingress_security_rules {
    icmp_options {
      code = "-1"
      type = "3"
    }
    protocol    = "1"
    source      = "10.0.0.0/16"
    source_type = "CIDR_BLOCK"
    stateless   = "false"
  }
  ingress_security_rules {
    description = "http"
    protocol    = "6"
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    stateless   = "false"
    tcp_options {
      max = "80"
      min = "80"
    }
  }
  ingress_security_rules {
    description = "proxy"
    protocol    = "6"
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    stateless   = "false"
    tcp_options {
      max = "3128"
      min = "3128"
    }
  }
  ingress_security_rules {
    protocol    = "6"
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    stateless   = "false"
    tcp_options {
      max = "22"
      min = "22"
    }
  }
  manage_default_resource_id = oci_core_vcn.MainVCN.default_security_list_id
}
