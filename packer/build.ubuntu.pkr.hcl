build {
  name = "hiring-testing-nginx"
  source "source.amazon-ebs.ubuntu" {
    ami_name          = "ubuntu-focal-hiring-testing-nginx-${local.timestamp}"
    ami_description   = "Testing Image with Broken Nginx Install"
  }

  provisioner "file" {
    source            = "./etc/Caddyfile"
    destination       = "/tmp/Caddyfile"
  }

  provisioner "shell" {
    script            = "./etc/init.sh"
    environment_vars = [
      "DOMAIN=${var.domain}",
      "SUB_DOMAIN=${var.sub_domain}"
    ]
  }

  provisioner "file" {
    source            = "./etc/scenarios/nginx/default"
    destination       = "/tmp/default"
  }

  provisioner "file" {
    source            = "./etc/scenarios/nginx/index.nginx-debian.html"
    destination       = "/tmp/index.nginx-debian.html"
  }

  provisioner "shell" {
    script            = "./etc/scenarios/nginx/nginx.sh"
  }
}

// build {
//   name = "hiring-testing-apache"
//   source "source.amazon-ebs.ubuntu" {
//     ami_name = "ubuntu-focal-hiring-testing-apache-${local.timestamp}"
//     ami_description = "Testing Image with Broken Apache Install"
//   }

//   provisioner "shell" {
//     script = "./etc/init.sh"
//   }

//   provisioner "file" {
//     source = "./key/broken-instance.pub"
//     destination = "/tmp/broken-instance.pub"
//   }

//   provisioner "shell" {
//     script = "./etc/broken-apache.sh"
//   }
// }

# broken bash script

# broken ruby app

# broken python app
