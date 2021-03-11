build {
  name = "hiring-testing-nginx"
  source "source.amazon-ebs.ubuntu" {
    ami_name          = "ubuntu-focal-hiring-testing-nginx-${local.timestamp}"
    ami_description   = "Testing Image with Broken Nginx Install"
  }

  provisioner "file" {
    source            = "./etc/scenarios/nginx/Caddyfile"
    destination       = "/tmp/Caddyfile"
  }

  provisioner "shell" {
    script            = "./etc/init.sh"
    environment_vars = [
      "DOMAIN=${var.domain}",
      "SUB_DOMAIN=${var.sub_domain}"
    ]
  }

  provisioner "shell-local" {
    inline = ["./build-hugo.sh nginx"]
    environment_vars = [
      "DOMAIN=${var.domain}",
      "SUB_DOMAIN=${var.sub_domain}"
    ]
  }

  provisioner "file" {
    source            = "../docs/scenarios/nginx/public"
    destination       = "/tmp/public"
    generated         = "true"
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
