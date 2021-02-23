source "amazon-ebs" "ubuntu" {
  # such comments ! Much wow !
  #access_key              = "${var.aws_access_key}"
  #ami_name = "ubuntu-20-04-base-image-${local.timestamp}"
  region                  = "${var.region}"
  instance_type           = "t2.micro"

  source_ami_filter {
    filters = {
      name                = "${var.base_ami_name}"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners                = ["${var.base_ami_owner}"]
  }
  ssh_username            = "ubuntu"
  communicator            = "ssh"

  tags = {
    build                 = "packer"
    build_date            = "{{timestamp}}"
    OS_Version            = "20.04"
    Base_AMI_Name         = "{{ .SourceAMIName}}"
  }
}
