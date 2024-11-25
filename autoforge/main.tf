```hcl
# Provide AWS Credentials
provider "aws" {
  region = "us-east-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

# Define necessary variables
variable "access_key" {
  description = "AWS Access Key"
  type        = string
}

variable "secret_key" {
  description = "AWS Secret Key"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  default     = "t2.micro"
}

# Security group to allow traffic
resource "aws_security_group" "test_center_sg" {
  name        = "test_center_security_group"
  description = "Test Center EC2 Security Group"

  ingress {
    from_port   = 22
    to_port     = 22
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

# AWS EC2 Instance resource
resource "aws_instance" "test-center" {
  ami           = "ami-0d0c5eac1d7ec37c9"
  instance_type = var.instance_type
  key_name      = "mykey"
  security_groups = [aws_security_group.test_center_sg.name]

  tags = {
    Name = "test-center"
  }
}

# Output the Instance ID and public IP
output "instance_id" {
  value = aws_instance.test-center.id
}

output "public_ip" {
  value = aws_instance.test-center.public_ip
}
```
In this code, instance type variable is hardcoded to "t2.micro". You can change it according to your needs. Security group allows traffic from and to all ip addresses (0.0.0.0/0) which is not the best practice but you can modify them as per your requirement.

Please replace `"mykey"` with your own key pair name.

Don't forget to add your AWS access key and secret key as environment variables or provide when calling terraform apply.
I also recommend moving the sensitive data like `access_key` and `secret_key` out from your code to environment variables for better security.

Please adjust your code according to your specific use case and AWS environment.