provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "web_server" {
    ami                    = "ami-0aeeebd8d2ab47354" //--Amazon Linux 2
    instance_type          = "t3.micro"
    vpc_security_group_ids = [aws_security_group.web_security_group.id]
    key_name = "YetAnotherKeyPair"
    
    user_data = templatefile("bootstrap.sh.tpl", { // Template File
      f_name = "Chris"
      l_name = "Gianelle"
      names  = ["John", "Angel", "David", "Victor", "Frank", "Melissa", "Kitana"]
    })

    tags = {
        Name  = "My Best Terraform Web Server"
        Owner = "Chris Gianelle"
    }
}

resource "aws_security_group" "web_security_group" {
    name = "web_server_security_group"
    description = "Security Group for my Terraform web server"

  #SSH
  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  #HTTP
  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  #HTTPS
  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  # Allow outgoing traffic to anywhere.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" //--any protocol
    cidr_blocks = ["0.0.0.0/0"]
  }


}