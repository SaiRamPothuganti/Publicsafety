provider "oci" {
  version = ">= 3.35.0"
}

module "network" {
  source               = "./modules/network"
  tenancy_ocid         = "${var.tenancy_ocid}"
  vcn_display_name     = "${var.vcn_display_name}"
  availability_domain  = "${var.availability_domain}"
  destination          = "${module.servicegateway.destination}"
  service_gateway_id   = "${module.servicegateway.service_gateway_id}"
  subnet_backend_cidr  = "${var.subnet_backend_cidr}"
  subnet_frontend_cidr = "${var.subnet_frontend_cidr}"
  vcn_cidr             = "${var.vcn_cidr}"
  oci_public_key       = "${var.oci_public_key}"
  user_ocid            = "${var.user_ocid}"
  compartment_ocid     = "${var.compartment_ocid}"
}

module "servicegateway" {
  source           = "./modules/service-gateway"
  tenancy_ocid     = "${var.tenancy_ocid}"
  user_ocid        = "${var.user_ocid}"
  compartment_ocid = "${var.compartment_ocid}"
  vcn_id           = "${module.network.vcn_id}"
}

module "image" {
  source           = "./modules/image"
  tenancy_ocid     = "${var.tenancy_ocid}"
  user_ocid        = "${var.user_ocid}"
  compartment_ocid = "${var.compartment_ocid}"
  vcn_id           = "${module.network.vcn_id}"
}

module "compute" {
  source                        = "./modules/compute-instance"
  tenancy_ocid                  = "${var.tenancy_ocid}"
  compartment_ocid              = "${var.compartment_ocid}"
  user_ocid                     = "${var.user_ocid}"
  compute_frontend_display_name = "${var.compute_frontend_display_name}"
  instance_frontend_shape       = "${var.instance_frontend_shape}"
  subnet_a                      = "${module.network.subnet_a}"
  subnet_b                      = "${module.network.subnet_b}"
  region                        = "${var.region}"
  availability_domain           = "${var.availability_domain}"
  ssh_public_key                = "${var.ssh_public_key}"
  oci_public_key                = "${var.oci_public_key}"
  private_key_path              = "${var.private_key_path}"
  fingerprint                   = "${var.fingerprint}"
  image                         = "${module.image.image_ocid}"
}
