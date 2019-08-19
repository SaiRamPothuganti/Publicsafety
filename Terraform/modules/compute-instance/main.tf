resource "oci_core_instance" "PublicInstance" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ads.availability_domains[var.availability_domain], "name")}"
  compartment_id = "${var.compartment_ocid}"
  display_name = "TFInstance${count.index}"
  shape = "${var.instance_frontend_shape}"

  create_vnic_details {
    subnet_id = "${var.subnet_b}"
    display_name = "primaryvnic"
    assign_public_ip = true
    hostname_label = "tfexampleinstance"
  }

  source_details {
    source_type = "image"
    source_id = "${var.instance_image_ocid[var.region]}"
  }
  preserve_boot_volume = false

  metadata {
    ssh_authorized_keys = "${var.ssh_public_key}"
    user_data = "${base64encode(file(var.BootStrapFile))}"
  }
  timeouts {
    create = "20m"
  }
}
