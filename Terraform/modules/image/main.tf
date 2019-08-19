resource "oci_core_image" "oml_image" {
    #Required
    compartment_id = "${var.compartment_id}"

    #Optional
    display_name = "OML_Compute_image"

    image_source_details {
        source_type = "objectStorageUri"
        source_uri = "https://objectstorage.us-ashburn-1.oraclecloud.com/p/4xJYgMRqXhf21YzBlxCm-HwRO2USRQV1Yi02sPLmpJM/n/orasenatdpltintegration01/b/PublicSafetyImageRepo/o/OML_PS2"
    }
}
