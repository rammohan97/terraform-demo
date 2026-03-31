# Creating Security Group
resource "aws_security_group" "roboshop_instance" {
    name = "roboshop-strict-sg"  

    egress  {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }

    # Block
    dynamic "ingress" {
        for_each = toset(var.ingress_port)
        content {
            from_port = ingress.value       # ingress is special variable which is used to access the value of for_each loop and value is used to access the value of each element in the list
            to_port = ingress.value
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
      
    }

    tags = {
        Name = "roboshop-strict-sg" 
    }
    
}