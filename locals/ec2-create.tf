# Creating EC2 Instance
resource "aws_instance" "terraform_instance" {
    for_each = toset(var.instances)
    ami = var.ami_id  
    instance_type = local.instance_type
    vpc_security_group_ids = [aws_security_group.allow-all.id]    
    #count=4   

    tags = merge (
      var.common_tags,
      {
        Name = "${local.common_name}-local-demo"  # Using local variable for common name
      }
     )
}

# Creating Security Group
resource "aws_security_group" "allow-all" {
    name = "${local.common_name}-allow-all"  # Using local variable for common name

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

    tags = merge (
      var.common_tags,
      {
        Name = "${local.common_name}-allow-all"  # Using local variable for common name
      }
    )
}