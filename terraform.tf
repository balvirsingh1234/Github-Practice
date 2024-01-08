terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "Balvirsinghca"
    workspaces {
      prefix = "my-app-"
    }
  }
}

terraform {
  required_version = ">=0.13"
}

provider "aws" {
  region     = "us-east-2"
  access_key = "AKIASVTMDHOI76Z7SB6S"
  secret_key = "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"
}

resource "aws_instance" "myec2" {
  count = var.new_instance ? 1 : 0
  ami             = "ami-0ee4f2271a4df2d7d"
  instance_type   = var.type
  vpc_security_group_ids  = [aws_security_group.allow_tls.id]
  key_name        = "Authentication"
  tags = { Name = var.tag[count.index] }
}

output "myec2_publicip1" {
  value = aws_instance.myec2[*].public_ip
}
