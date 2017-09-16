// Define output variable for the app external ip
output "app_external_ip" {
  value = "${module.app.app_external_ip}"
}
