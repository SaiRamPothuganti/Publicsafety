variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "compartment_ocid" {}
variable "region" {}
variable "ssh_public_key" {}
variable "oci_public_key" {}
variable "private_key_path" {}
variable "availability_domain" {
  default = "2"
}


variable "NumInstances" {
  default = 1
}

variable "DBSize" {
  default = "50"
}

variable "BootStrapFile" {
  default = "./userdata/bootstrap.sh.tpl"
}

variable "volume_attachment_device" {
  default = "/dev/oracleoci/oraclevdb"
}

variable "vcn_display_name" {
  default = "Public_Safety_VCN"
}

variable "vcn_cidr" {
  default = "10.0.0.0/16"
}

variable "subnet_backend_cidr" {
  default = "10.0.1.0/24"
}

variable "subnet_frontend_cidr" {
  default = "10.0.2.0/24"
}

variable "compute_frontend_display_name" {
  default = "Public_Safety_OML_Instance"
}

variable "instance_frontend_shape" {
  default = "VM.Standard2.1"
}

variable "admin_password" {}
