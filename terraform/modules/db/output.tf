output "db_external_ip" {
  value = "${module.db_instance.external_ip}"
}

output "db_internal_ip" {
  value = "${module.db_instance.internal_ip}"
}
