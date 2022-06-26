output "AMD_public_ip" {
  value = oci_core_instance.instance-AMD[*].public_ip
}
output "ARM_public_ip" {
  value = oci_core_instance.instance-ARM[*].public_ip
}
