locals {
  image_id = var.release != "" ? var.release : formatdate("YYYYMMDDhhmmss", timestamp())
}

variable "id_do_dono" {
  type    = number
  default = "405151343467"
}

source "amazon-ebs" "ubuntu-us-east-1" {
  ssh_username  = var.user
  instance_type = "t3.micro"
  region        = "us-east-1"
  ami_name      = replace("loki-${local.image_id}", ".", "-")
  tags = {
    OS_Version    = "Loki aula ao vivo"
    Release       = "${local.image_id}"
    Base_AMI_Name = "{{ .SourceAMIName }}"
    Extra         = "{{ .SourceAMITags.TagName }}"
  }
  source_ami_filter {
    filters = {
      virtualization-type = "hvm"
      name                = "base-*"
      root-device-type    = "ebs"
    }
    owners      = ["${var.id_do_dono}"]
    most_recent = true
  }
}

