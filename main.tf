#----------------------------------------------------------
# Provisioning an AWS Instance with a Docker Container
#
# Create: 
#    - Security Group for Web Server
#    - Using user_data installing and Setting up Docker on Web Server
#    - Pulling Docker Image from Docker Hub
#    - Launching Docker container
#
# Made by Vitali Aleksandrov 5-May-2023
#-----------------------------------------------------------

provider "aws" {
  region = "eu-central-1"
}

resource "aws_eip" "main" {
  instance = aws_instance.main.id
}

resource "aws_instance" "main" {
  ami                    = "ami-0ec7f9846da6b0f61"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.main.id]
  user_data              = file("userdata.tpl")
}

resource "aws_security_group" "main" {
  dynamic "ingress" {
    for_each = ["80", "443", "22"]
    content {
      to_port     = ingress.value
      from_port   = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    to_port     = 0
    from_port   = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
