output "Okit_url" {
  value = "${join("",["http://", oci_core_instance.okit-inst.public_ip,"/okit/designer"])}"
}

output "Okit_url2" {
  value = "${join("",["http://", oci_core_instance.okit-inst.public_ip,"/okit/designer"])}"
}

output "dev" {
  value = "Made with \u2764 by Fabio Silva"
}

output "comments" {
  value = "The application URL will be unavailable for a few minutes after provisioning, while the application is configured"
}


