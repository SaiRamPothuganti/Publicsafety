data "oci_identity_availability_domains" "ads" {
  compartment_id = "${var.compartment_ocid}"
}

data "template_file" "init" {
  template = "${file(var.BootStrapFile)}"

  vars {
    region        = "${var.region}"
    user_ocid     = "${var.user_ocid}"
    fingerprint   = "${var.fingerprint}"
    tenancy_ocid  = "${var.tenancy_ocid}"
    oci_public_key     = "${file(var.private_key_path)}"
    private_key_path     = "${file(var.private_key_path)}"
    compartment_ocid    = "${var.compartment_ocid}"
  }
}

# resource "null" "export_rendered_template" {
#   provisioner "local-exec" {
#     command = "cat > test_output.json <<EOL\n${join(",\n", data.template_file.init.*.rendered)}\nEOL"
#   }
# }
