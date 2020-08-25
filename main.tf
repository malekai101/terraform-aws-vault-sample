provider "aws" {
    region = var.region
}

data aws_ami "vault_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["csmith-vault*"]
  }

  owners = ["self"]
}

resource "aws_security_group" "allow_vault_access" {
  name        = "allow_vault_http"
  description = "Allow vault inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "Vault UI"
    from_port   = 8200
    to_port     = 8200
    protocol    = "tcp"
    cidr_blocks = [var.admin_ip]
  }

  ingress {
    description = "Vault SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.admin_ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_vault_http"
  }
}

resource "aws_instance" "vault" {
  ami                         = data.aws_ami.vault_ami.id
  instance_type               = "t2.large"
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.allow_vault_access.id]
  key_name                    = var.key
  associate_public_ip_address = true

  tags = {
    Project = var.project_name
    Name    = "Vault Server"
  }
}