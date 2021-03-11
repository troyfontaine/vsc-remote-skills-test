build {
  name                = "hiring-testing-k8s"
  source "source.amazon-ebs.ubuntu" {
    ami_name          = "ubuntu-focal-hiring-testing-k8s-${local.timestamp}"
    ami_description   = "Testing Image with k8s Install"
  }

  provisioner "file" {
    source            = "./etc/scenarios/k8s/Caddyfile"
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
    inline            = ["./build-hugo.sh k8s"]
    environment_vars  = [
      "DOMAIN=${var.domain}",
      "SUB_DOMAIN=${var.sub_domain}"
    ]
  }

  provisioner "file" {
    source            = "../docs/scenarios/k8s/public"
    destination       = "/tmp/public"
    generated         = "true"
  }

  provisioner "shell" {
    script            = "./etc/scenarios/k8s/k8s.sh"
  }
}
