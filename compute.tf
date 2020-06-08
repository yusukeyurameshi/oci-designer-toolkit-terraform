resource "oci_core_instance" "okit-inst" {
  display_name        = "Oracle Designer Toolkit"
  compartment_id      = var.compartment_ocid
  availability_domain = lookup(data.oci_identity_availability_domains.availability_domains.availability_domains[0],"name")
  shape               = var.Instance_shape

  source_details {
    source_id   = lookup(data.oci_core_images.OLImageOCID.images[0], "id")
    source_type = "image"
  }

  create_vnic_details {
    subnet_id        = oci_core_subnet.okit_subnet_public.id
    hostname_label   = "okit"
    assign_public_ip = "true"
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key

    user_data = base64encode(file("./cloud-init/cloud-init.sh"))
  }

}