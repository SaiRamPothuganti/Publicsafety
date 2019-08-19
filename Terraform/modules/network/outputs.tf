output "subnet_b" {
  description = "This is the frontend subnet ocid."
  value       = "${oci_core_subnet.subnet_b.id}"
}

output "subnet_a" {
  description = "This is the backend subnet ocid."
  value       = "${oci_core_subnet.subnet_a.id}"
}

output "vcn_id" {
  description = "This is the VCN ocid."
  value       = "${oci_core_vcn.default_vcn.id}"
}
