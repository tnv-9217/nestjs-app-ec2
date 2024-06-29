# main.tf

# Configure the AWS provider
provider "aws" {
  region     = "us-east-1"
  access_key = "AKIA2FDKIHHPMMZ2OYGK"
  secret_key = "WMVTERzf+vNL5FEqtgnMKzsfAnjsREn2ClGumB4A"
}

# Define the EC2 instance
resource "aws_instance" "ec2_instance" {
  ami           = "ami-04b70fa74e45c3917" # Replace with your desired AMI ID
  instance_type = "t2.micro"              # Instance type based on your requirements
  key_name      = "nestjs-app"            # Replace with your SSH key pair name

  tags = {
    Name = "NestJS-App-Instance"
  }

  # Configure the provisioner to run Docker commands
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",               # Update package lists
      "sudo apt-get install -y docker.io", # Install Docker
      "sudo systemctl start docker",       # Start Docker service
      "sudo systemctl enable docker",      # Enable Docker service on boot
      "sudo docker login -u tladdha0818 -p Tanvi@1808",
      "sudo docker pull tladdha0818/nestjs-app-ec2:latest",              # Replace with your NestJS Docker image and tag
      "sudo docker run -d -p 80:3010 tladdha0818/nestjs-app-ec2:latest", # Example: Run Docker container on port 80
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"                            # Replace with your EC2 instance's SSH user (for Ubuntu instances)
      private_key = file("./nestjs-app.pem")            # Replace with path to your SSH private key
      host        = aws_instance.ec2_instance.public_ip # Public IP of your EC2 instance
    }
  }
}
