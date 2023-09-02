locals {
  image_id = var.release != "" ? var.release : formatdate("YYYYMMDDhhmmss", timestamp())
}

source "amazon-ebs" "ubuntu-us-east-1" {
  ssh_username  = var.user
  instance_type = "t3.micro"
  region        = "us-east-1"
  ami_name      = replace("loki-${local.image_id}", ".", "-")
  tags = {
    OS_Version    = "Ubuntu"
    Release       = "${local.image_id}"
    Base_AMI_Name = "{{ .SourceAMIName }}"
    Extra         = "{{ .SourceAMITags.TagName }}"
  }
  source_ami = data.hcp-packer-image.base-image-aovivo.id
}

