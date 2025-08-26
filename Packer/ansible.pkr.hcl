packer {
  required_plugins {
    amazon = {
      version = "1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
    ansible = {
      version = "~> 1"
      source  = "github.com/hashicorp/ansible"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "wordpress-{{ timestamp }}"
  instance_type = "t2.micro"
  region        = "us-east-1"
  source_ami = "ami-0bbdd8c17ed981ef9"
  ssh_username = "ubuntu"
  ssh_keypair_name = "ansible-key-may"
  ssh_private_key_file = "~/.ssh/id_rsa"
}


build {
  name    = "learn-packer"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]

  provisioner "ansible" {
    playbook_file = "main.yaml"
  }
}

