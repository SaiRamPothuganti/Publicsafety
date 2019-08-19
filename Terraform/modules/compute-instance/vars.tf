variable "tenancy_ocid" {}
variable "compartment_ocid" {}
variable "subnet_a" {}
variable "subnet_b" {}
variable "user_ocid" {}
variable "compute_frontend_display_name" {}
variable "instance_frontend_shape" {}
variable "region" {}
variable "ssh_public_key" {}
variable "oci_public_key" {}
variable "private_key_path" {}
variable "fingerprint" {}
variable "availability_domain" {}


variable "instance_image_ocid" {
  type = "map"
  default = {
    us-ashburn-1 = "ocid1.image.oc1.iad.aaaaaaaaz2tw6zmfiwmbf6ofqufruviv6upzfpup35fjcbtu3un75gxglqpq"
  }
}

variable "compute_hostname1" {
  default = "pub-safety-OML"
}

variable "BootStrapFile" {
  default = "./modules/compute-instance/userdata/bootstrap.sh.tpl"
}

variable "http-proxy" {
  default = "file(./userdata/http-proxy.conf)"
}
variable "docker-sysconfig" {
  default = "file(./userdata/docker-sysconfig.conf)"
}
