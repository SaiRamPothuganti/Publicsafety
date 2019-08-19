data "oci_core_services" "test_services" {
  filter {
    name    = "name"
    values  = ["All .* Services In Oracle Services Network"]
    regex   = true
  }
}

data "oci_core_service_gateways" "test_service_gateways" {
  compartment_id = "${var.compartment_ocid}"
  state  = "AVAILABLE"
  vcn_id = "${var.vcn_id}"
}
