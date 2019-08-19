output "image_ocid" {
  description = "This is the customer image ocid"
  value = "${oci_core_image.oml_image.id}"
}
