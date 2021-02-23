# Configure our provider and region
provider "aws" {
  version                     = "~> 3.0"
  region                      = "us-west-2"
}

# Get our AWS Account ID
data "aws_caller_identity" "current" {}

# Generate a random password for the Code-Server
resource "random_password" "password" {
  length                      = 16
  special                     = true
  override_special            = "_%@"
}

# Generate a private key to use with the testing Instance
resource "tls_private_key" "this" {
  algorithm                   = "RSA"
  rsa_bits                    = 4096
}

module "key_pair" {
  source                      = "terraform-aws-modules/key-pair/aws"

  key_name                    = "testing-key-pair"
  public_key                  = tls_private_key.this.public_key_openssh

  tags = {
    Terraform                 = "<3"
  }
}

# Write the private key file to the system
resource "local_file" "private_key" {
  content                     = tls_private_key.this.private_key_pem
  filename                    = "${path.module}/testing-key-pair.pem"
  file_permission             = 0600
}

# Determine the external IPv4 address of the launching machine to allow SSH access
data "external" "myipaddr" {
  program                     = ["bash", "-c", "curl -s 'https://api.ipify.org?format=json'"]
}

# Create our security group
resource "aws_security_group" "testing_instance" {
  name                        = "testing_instance"
  description                 = "Security Group for DevOps Testing Instance"

  # We keep egress here since we don't really need to modify this
  egress {
    from_port                 = 0
    to_port                   = 0
    protocol                  = "-1"
    cidr_blocks               = ["0.0.0.0/0"]
  }

  tags = {
    Name                      = "testing-instance"
  }
}

# Create our individual rules that allow us to modify them as needed without destroying the security group
resource "aws_security_group_rule" "web" {
  description                 = "Customer Web Traffic to App"
  type                        = "ingress"
  from_port                   = var.http_port
  to_port                     = var.http_port
  protocol                    = "tcp"
  cidr_blocks                 = ["0.0.0.0/0"]
  security_group_id           = aws_security_group.testing_instance.id
}

resource "aws_security_group_rule" "code-server" {
  description                 = "Secured Testing Tool Access"
  type                        = "ingress"
  from_port                   = var.vs_port
  to_port                     = var.vs_port
  protocol                    = "tcp"
  cidr_blocks                 = ["0.0.0.0/0"]
  security_group_id           = aws_security_group.testing_instance.id
}

resource "aws_security_group_rule" "ssh" {
  description                 = "SSH Access to Host"
  type                        = "ingress"
  from_port                   = var.ssh_port
  to_port                     = var.ssh_port
  protocol                    = "tcp"
  cidr_blocks                 = ["${data.external.myipaddr.result.ip}/32"]
  security_group_id           = aws_security_group.testing_instance.id
}

# Filter to determine our AMI image to use - You can modify this, check the README
data "aws_ami" "ubuntu" {
  most_recent                 = true

  filter {
    name                      = "name"
    values                    = [var.image_name_filter]
  }

  filter {
    name                      = "virtualization-type"
    values                    = ["hvm"]
  }

  owners                      = [data.aws_caller_identity.current.account_id]
}

# Configure our instance to launch
resource "aws_instance" "testing_instance" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  availability_zone           = "us-west-2a"
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.testing_instance.id]
  key_name                    = "testing-key-pair"

  ebs_block_device {
    device_name               = "/dev/sda1"
    volume_size               = "16"
    volume_type               = "gp3"

    tags = {
      Name                    = "testing_instance_root"
    }
  }

  # Update the password used for Code-Server
  provisioner "file" {
    content                    = templatefile("config.yaml.tpl", { vscode-password           = random_password.password.result})
    destination                = "~/.config/code-server/config.yaml"

    connection {
      type                     = "ssh"
      user                     = "ubuntu"
      private_key              = tls_private_key.this.private_key_pem
      host                     = self.public_dns
    }
  }

  tags = {
    Name                      = "testing_instance"
    Env                       = "non-prod"
    Code-Server-password      = random_password.password.result
  }
}

# Select our Route 53 Hosted Zone
data "aws_route53_zone" "selected" {
  name                        = var.domain
  private_zone                = false
}

# Add our A record for the testing hostname to our Route 53 Hosted Zone
resource "aws_route53_record" "test" {
  zone_id                     = data.aws_route53_zone.selected.zone_id
  name                        = data.aws_route53_zone.selected.name
  type                        = "A"
  ttl                         = "60"
  records                     = [aws_instance.testing_instance.public_ip]
}
