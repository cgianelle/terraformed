provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "my_ubuntu" {
  ami           = "ami-09e67e426f25ce0d7"
  instance_type = "t3.micro"
  vpc_security_group_ids = [ aws_security_group.my_ubuntu-ec2-sg.id ]
  key_name = "YetAnotherKeyPair"

  tags = {
    Name = "My-Ubuntu-Server"
    Owner = "Chris Gianelle"
    Project = "My first terraform project"
  }
}

resource "aws_security_group" "my_ubuntu-ec2-sg" {
  name        = "ssh-security-group"
  description = "allow inbound access for ssh"

  # Allow SSH
  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  # Allow outgoing traffic to anywhere.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}