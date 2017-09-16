// Define output variable with info of how to connect to app instance
output "app_connection_info" {
  value = <<EOF

IP address of "${var.app_name}" instance is: ${module.app.app_external_ip}

Connect to "${var.app_name}" instance using SSH:

 ssh -o "StrictHostKeyChecking=no" ${var.app_username}@${module.app.app_external_ip} -i ~/.ssh/${var.app_username}
EOF
}
