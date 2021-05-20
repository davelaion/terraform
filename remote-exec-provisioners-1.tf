provider "aws" {
  region     = "us-east-1"
  access_key = "ACCESS_KEY_ID"
  secret_key = "SECRET_KEY_ID"
}

resource "aws_security_group" "allow_access" {
  name        = "allow_access"

  ingress {
    description = "HTTP ACCESS"
		from_port = 80
		to_port = 80
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

  ingress {
    description = "SSH ACCESS"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}
}

resource "aws_instance" "myec2" {
   ami = "ami-0d5eff06f840b45e9"
   instance_type = "t2.micro"
   key_name = "terraform1"
   vpc_security_group_ids = [aws_security_group.allow_access.id]

   connection {
     type        = "ssh"
     host        = self.public_ip
     user        = "ec2-user"
     private_key = file("./terraform1.pem")
   }

provisioner "remote-exec" {
  inline = [
    "sudo amazon-linux-extras install -y nginx1.12",
    "sudo systemctl start nginx"
    "sudo systemctl is-active nginx > /var/log/check1.log"
  ]

}

}
