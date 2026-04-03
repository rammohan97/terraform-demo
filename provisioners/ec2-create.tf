# Creating EC2 Instance
resource "aws_instance" "terraform_instance" {
    ami = var.ami_id  
    instance_type = var.instance_type
    vpc_security_group_ids = [aws_security_group.allow-all.id]       

    tags = var.ec2_tags

    provisioner "local-exec" {
        command = "echo 'EC2 Instance ${self.private_ip} has been created successfully!'"
        on_failure = continue
    }

    provisioner "local-exec" {
        command = "echo 'EC2 Instance ${self.id} has been destroyed'"
        when = destroy
    }

    connection {
      type = "ssh"
      user = "ec2-user"
      password = "DevOps321"
      host = self.public_ip 
    }

    provisioner "remote-exec" {
      inline = [
        "sudo dnf install nginx -y",
        "sudo systemctl start nginx",
      ]
    }

    provisioner "remote-exec" {
      inline = [
        "sudo systemctl stop nginx",
        "echo successfully stopped nginx",
      ]
      when = destroy
    }
}

# Creating Security Group
resource "aws_security_group" "allow-all" {
    name = var.sg_name

    egress  {
      from_port = var.egress_from_port # From port 0 to port 0 means all ports
      to_port = var.egress_to_port
      protocol = var.protocol  # -1 means all protocols
      cidr_blocks = var.cidr  #internet wide access
    }

    ingress {
      from_port = var.ingress_from_port # From port 0 to port 0 means all ports
      to_port = var.ingress_to_port
      protocol = var.protocol  # -1 means all protocols
      cidr_blocks = var.cidr  #internet wide access
    }

    tags = var.sg_tags
}