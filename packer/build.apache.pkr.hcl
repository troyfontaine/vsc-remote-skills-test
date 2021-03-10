build {
  name                = "hiring-testing-apache"
  source "source.amazon-ebs.ubuntu" {
    ami_name          = "ubuntu-focal-hiring-testing-apache-${local.timestamp}"
    ami_description   = "Testing image with broken apache install"
  }

  provisioner "file" {
    source            = "./etc/scenarios/apache/Caddyfile"
    destination       = "/tmp/Caddyfile"
  }

  provisioner "shell" {
    script            = "./etc/init.sh"
    environment_vars  = [
      "DOMAIN=${var.domain}",
      "SUB_DOMAIN=${var.sub_domain}"
    ]
  }

  provisioner "shell-local" {
    inline            = ["./build-hugo.sh apache"]
    environment_vars  = [
      "DOMAIN=${var.domain}",
      "SUB_DOMAIN=${var.sub_domain}"
    ]
  }

  provisioner "file" {
    source            = "../docs/scenarios/apache/public"
    destination       = "/tmp/public"
    generated         = "true"
  }

  provisioner "file" {
    source            = "./etc/scenarios/apache/proxy.conf"
    destination       = "/tmp/proxy.conf"
  }

  provisioner "file" {
    source            = "./etc/scenarios/apache/web-app.conf"
    destination       = "/tmp/web-app.conf"
  }

  provisioner "file" {
    source            = "./etc/scenarios/apache/index.htm"
    destination       = "/tmp/index.htm"
  }

  provisioner "shell" {
    script            = "./etc/scenarios/apache/apache.sh"
  }
}
