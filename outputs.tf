output "public_ip" {
  value       = aws_instance.testing_instance.public_ip
  description = "The public IP address of the testing instance"
}

output "url" {
  value       = "https://${var.domain}:8443/login"
  description = "The URL to use to access the code server web app"
}

output "code_server_password" {
  value       = random_password.password.result
  description = "The password used to access the code server web app"
}

output "my_public_ip" {
  value = data.external.myipaddr.result.ip
}
