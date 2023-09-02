data "hcp-packer-image" "base-image-aovivo" {
  bucket_name     = "base-image-aovivo"
  channel         = "prod"
  cloud_provider  = "aws"
  region          = "us-east-1"
}