resource "aws_instance" "myapp1" {
  ami = "ami-0d5eff06f840b45e9"
  instance_type = "t2.micro"

  provisioner "local-exec" {
    command = "echo ${aws_instance.myapp1.id} >> current_ec2_instances.txt ; echo ${aws_instance.myapp1.instance_type} >> current_ec2_instances.txt ; echo ${aws_instance.myapp1.private_ip} >> current_ec2_instances.txt"
  }
}
