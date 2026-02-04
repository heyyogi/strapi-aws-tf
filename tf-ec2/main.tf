provider "aws" {
  region = "ap-south-1"
}

resource "aws_security_group" "strapi_sg" {
    name        = "strapi_sg"
    description = "Security group for Strapi EC2 instance"
    
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port   = 1337
        to_port     = 1337
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
output "aws_security_group"  {
    value = aws_security_group.strapi_sg.id
}
# Create an EC2 instance
resource "aws_instance" "strapi" {
  ami = var.ami
  instance_type = var.instance_type
  key_name = var.key_name
  security_groups = [aws_security_group.strapi_sg.name]

user_data = <<-EOF
#!/bin/bash
# Update packages
sudo apt update -y
sudo apt install -y nodejs npm

# Install Strapi globally
sudo npm install -g npx

# Create Strapi project
cd /home/ubuntu
npx create-strapi-app strapi-app --quickstart --no-run

# Move into project
cd strapi-app

# Install PM2 to keep Strapi running
sudo npm install -g pm2

# Start Strapi with PM2
pm2 start npm --name "strapi" -- run develop
pm2 startup systemd
pm2 save
EOF

    tags = {
        Name = "StrapiInstance"
    }
}

output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.strapi.id
}

output "instance_name" {
  description = "The Name tag of the EC2 instance"
  value       = aws_instance.strapi.tags["Name"]
}