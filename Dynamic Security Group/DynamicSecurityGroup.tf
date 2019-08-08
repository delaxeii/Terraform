#----------------------------------
# My Terraform
#
# Build WebServer
#
# Made by Andrei Leonovich
#-----------------------------------


provider "aws" {
  region = "eu-central-1"
}


resource "aws_security_group" "my_webserver" {
  name        = "dynamic_SecurityGroup"
  description = "dynamic_security_group"

  dynamic "ingress" {
    for_each = ["80", "8080", "1541", "443"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.10.0.0/16"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "MyWebServer SecurityGroup"
    Owner   = "Andrei Leonovich"
    Project = "MyLessonTerraform-2"
  }
}
