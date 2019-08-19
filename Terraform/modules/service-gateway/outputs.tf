output "services" {
  value = ["${data.oci_core_services.test_services.services}"]
}

output "service_gateways" {
  value = ["${data.oci_core_service_gateways.test_service_gateways.service_gateways}"]
}

output "destination" {
  value = "${lookup(data.oci_core_services.test_services.services[0], "cidr_block")}"
}

output "service_gateway_id" {
  value = "${oci_core_service_gateway.test_service_gateway.id}"
}
