#################### Bastion Instance
resource "aws_instance" "Bastion" {
 ami = "ami-d5c18eba"
 instance_type = "t2.micro"
 subnet_id = "${aws_subnet.web-subnet-1.id}"
  # the security group
 vpc_security_group_ids = ["${aws_security_group.bastion.id}"]
 tags = {
    Name = "Bastion Server"
  }

}

###################### Bastion Elastic IP
resource "aws_eip" "bastion_eip" {
 instance = "${aws_instance.Bastion.id}"
 vpc      = true
}