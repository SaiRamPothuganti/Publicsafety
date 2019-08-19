# This is the network VCN main.tf

resource "oci_core_vcn" "default_vcn" {
  #Required
  cidr_block     = "${var.vcn_cidr}"
  compartment_id = "${var.compartment_ocid}"
  dns_label      = "vcn"
  display_name   = "${var.vcn_display_name}"
}

resource "oci_core_internet_gateway" "gateway" {
  compartment_id = "${var.compartment_ocid}"
  display_name   = "Frontend Internet Gateway"
  vcn_id         = "${oci_core_vcn.default_vcn.id}"
}

resource "oci_core_route_table" "route_table" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${oci_core_vcn.default_vcn.id}"
  display_name   = "Frontend Route Table"

  route_rules {
    destination        = "0.0.0.0/0"
    network_entity_id = "${oci_core_internet_gateway.gateway.id}"
  }
}

resource "oci_core_route_table" "private_route_table" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${oci_core_vcn.default_vcn.id}"
  display_name   = "Backend Route Table"
  route_rules {
    destination       = "${var.destination}"
    destination_type  = "SERVICE_CIDR_BLOCK"
    network_entity_id = "${var.service_gateway_id}"
  }
}

resource "oci_core_security_list" "private_security_list" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${oci_core_vcn.default_vcn.id}"

  display_name = "Backend Security List"

  // allow outbound tcp traffic on all ports

  egress_security_rules {
    destination      = "${var.destination}"
    destination_type = "SERVICE_CIDR_BLOCK"
    protocol         = "all"
  }
  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "all"
  }
  // allow inbound ssh traffic from a specific port
  ingress_security_rules = {
    protocol  = "6"           // tcp
    source    = "10.0.2.0/24"
    stateless = false

    tcp_options {
      // these represent destination port range
      "min" = 22
      "max" = 22
    }
  }
  // allow inbound port 8080 traffic from anywhere
  ingress_security_rules = {
    protocol  = "6"           // tcp
    source    = "10.0.2.0/24"
    stateless = false

    tcp_options {
      // these represent destination port range
      "min" = 8080
      "max" = 8080
    }
  }
  // allow inbound port 80 traffic from anywhere
  ingress_security_rules = {
    protocol  = "6"           // tcp
    source    = "10.0.2.0/24"
    stateless = false

    tcp_options {
      // these represent destination port range
      "min" = 80
      "max" = 80
    }
  }
  // allow inbound icmp traffic of a specific type
  ingress_security_rules {
    protocol  = "1"           // icmp
    source    = "10.0.2.0/24"
    stateless = false
  }
}

#actual private instance
resource "oci_core_subnet" "subnet_a" {
  availability_domain        = "${lookup(data.oci_identity_availability_domains.ads.availability_domains[var.availability_domain],"name")}"
  cidr_block                 = "${var.subnet_backend_cidr}"
  display_name               = "Backend Subnet"
  dns_label                  = "privsub"
  compartment_id             = "${var.compartment_ocid}"
  vcn_id                     = "${oci_core_vcn.default_vcn.id}"
  security_list_ids          = ["${oci_core_security_list.private_security_list.id}"]
  route_table_id             = "${oci_core_route_table.private_route_table.id}"
  dhcp_options_id            = "${oci_core_vcn.default_vcn.default_dhcp_options_id}"
  prohibit_public_ip_on_vnic = "true"
}

#public subnet
resource "oci_core_subnet" "subnet_b" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ads.availability_domains[var.availability_domain],"name")}"
  cidr_block          = "${var.subnet_frontend_cidr}"
  display_name        = "Frontend Subnet"
  dns_label           = "pubsub"
  compartment_id      = "${var.compartment_ocid}"
  vcn_id              = "${oci_core_vcn.default_vcn.id}"
  route_table_id      = "${oci_core_route_table.route_table.id}"
  dhcp_options_id     = "${oci_core_vcn.default_vcn.default_dhcp_options_id}"
}
