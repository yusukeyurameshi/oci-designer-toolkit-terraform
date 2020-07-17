terraform {
  required_version = ">= 0.12.0"
}

# Required by the OCI Provider
variable compartment_ocid {}
variable region {}

# Key used to SSH to OCI VMs
variable ssh_public_key {}

# ---------------------------------------------------------------------------------------------------------------------
# Optional variables
# The defaults here will give you a cluster.  You can also modify these.
# ---------------------------------------------------------------------------------------------------------------------
variable Instance_shape {default = "VM.Standard.E2.1"}
variable Instance_shape_free {default = "VM.Standard.E2.1.Micro"}
variable InstanceOS {default = "Oracle Linux"}
variable InstanceOSVersion {default = "7.8"}
variable free_tier_resources {default = true}