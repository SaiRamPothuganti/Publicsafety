output "public_ip" {
  value = "${oci_core_instance.PublicInstance.public_ip}"
}
