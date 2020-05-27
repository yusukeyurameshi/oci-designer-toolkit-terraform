resource oci_core_vcn virtual_network {
  cidr_block     = "10.0.0.0/16"
  compartment_id = var.compartment_ocid
  defined_tags   = {}

  display_name = "okit_vcn"
  dns_label    = "okit"
}

data "oci_identity_availability_domains" "availability_domains" {
  compartment_id = var.compartment_ocid
}

resource "oci_core_internet_gateway" "internet_gateway" {
  display_name   = "okit-IGW"
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.virtual_network.id
}

resource "oci_core_route_table" "route_table" {
  display_name   = "route_table"
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.virtual_network.id

  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.internet_gateway.id
  }
}

resource "oci_core_security_list" "security_list" {
  display_name   = "security_list"
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.virtual_network.id

  egress_security_rules = [{
    protocol    = "All"
    destination = "0.0.0.0/0"
  }]

  ingress_security_rules = [{
    protocol = "All"
    source   = "10.0.0.0/24"
  },
    {
      protocol = "6"

      source      = "0.0.0.0/0"
      source_type = "CIDR_BLOCK"
      stateless   = "false"

      tcp_options {
    max = "80"
    min = "80"

    }
    },
    {
      protocol = "6"

      source      = "0.0.0.0/0"
      source_type = "CIDR_BLOCK"
      stateless   = "false"

      tcp_options {
    max = "22"
    min = "22"

    }
    }]

}

resource oci_core_subnet okit_subnet_public {
  cidr_block     = "10.0.0.0/24"
  compartment_id = var.compartment_ocid
  defined_tags   = {}

  dhcp_options_id = oci_core_vcn.virtual_network.default_dhcp_options_id
  display_name    = "PubOkit"
  dns_label       = "okit"

  prohibit_public_ip_on_vnic = "false"
  route_table_id             = oci_core_route_table.route_table.id

  security_list_ids = [
    oci_core_security_list.security_list.id,
  ]

  vcn_id = oci_core_vcn.virtual_network.id
}
