provider "aws" {
  region = "us-east-1"
}

resource "aws_lightsail_instance" "web_server" {
  name              = "web-server"
  availability_zone = "us-east-1a"
  blueprint_id      = "centos7"
  bundle_id         = "nano_2_0"

  user_data = <<-EOF
    #!/bin/bash
    sudo yum install httpd -y
    sudo systemctl start httpd
    sudo systemctl enable httpd
    echo "<h1>This Server is created using Terraform </h1>" | sudo tee /var/www/html/index.html
    EOF
}

output "public_ip" {
  value = aws_lightsail_instance.web_server.public_ip_address
}
