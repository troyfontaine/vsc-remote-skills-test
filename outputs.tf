output "ssh_connection" {
  value       = "ssh ubuntu@${aws_instance.testing_instance.public_ip} -i ./testing-key-pair.pem"
  description = "To connect to the instance, use this command from within this directory"
}

output "code_server_url" {
  value       = "https://${var.sub_domain}${var.domain}:8443/login"
  description = "The URL to use to access the code server web app"
}

output "code_server_password" {
  value       = random_password.password.result
  description = "The password used to access the code server web app"
}

output "docs_url" {
  value       = "https://${var.sub_domain}${var.domain}/docs/"
  description = "The URL to use to access the documentation on how to complete the test"
}

output "my_public_ip" {
  value = data.external.myipaddr.result.ip
  description = "The external IP that SSH is allowed into the testing instance from"
}
