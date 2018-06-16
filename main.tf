# Getting details about cloud provider.

provider "aws" {
access_key = "${var.aws_access_key}"
secret_key = "${var.aws_secret_key}"
region = "${var.region}"
}

# Create resource with AMI and type.
resource "aws_instance" "ek" {
ami = "${lookup(var.test-ami, var.region)}"
instance_type = "t2.micro"
count = "${var.elasticsearch_kibana_count}"
tags {
  Name = "Elasticsearch-Kibana-Ubuntu-16.04-LTS-${count.index}"
  }
key_name = "${aws_key_pair.deployer.id}"
user_data = "${data.template_file.init.rendered}"
}



resource "aws_instance" "Node" {
ami = "${lookup(var.test-ami, var.region)}"
instance_type = "t2.micro"
count = "${var.forwarder_count}"
tags {
  Name = "Forwarder-Ubuntu-16.04-LTS-${count.index}"
  }
key_name = "${aws_key_pair.deployer.id}"
user_data = "${data.template_file.init.rendered}"

/*provisioner "local-exec" {
    command = "echo ${aws_instance.Node.tags.Name} = ${aws_instance.Node.private_ip} > private_ips.txt"
  }

provisioner "remote-exec" {
    inline = [
      "sudo apt update && sudo apt install nginx -y",
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      agent       = false
      private_key = "${file("~/.ssh/id_rsa")}"
    }
}*/
}


resource "aws_instance" "Node1" {
ami = "${lookup(var.test-ami, var.region)}"
instance_type = "t2.micro"
count = "${var.source_aggregater_count}"
tags {
  Name = "Source-Aggregater-Ubuntu-16.04-LTS-${count.index}"
  }
key_name = "${aws_key_pair.deployer.id}"
user_data = "${data.template_file.init.rendered}"
depends_on = ["aws_instance.Node"]
}

resource "aws_instance" "Node2" {
ami = "${lookup(var.test-ami, var.region)}"
instance_type = "t2.micro"
count = "${var.destination_aggregater_count}"
tags {
  Name = "Desination-Aggregater-Ubuntu-16.04-LTS-${count.index}"
  }
key_name = "${aws_key_pair.deployer.id}"
user_data = "${data.template_file.init.rendered}"
depends_on = ["aws_instance.Node1"]
}


# Key pair generate
resource "aws_key_pair" "deployer" {
  key_name   = "${var.key_name}"
  public_key = "${file("/opt/terraform/base/scripts/my_key.pub")}"
}
/*
resource "aws_iam_user" "user" {
  name = "ubuntu"
  path = "/"
}

resource "aws_iam_user_ssh_key" "user" {
  username   = "${aws_iam_user.user.name}"
  encoding   = "SSH"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDPt2JZwZT3j9fAUqbG8d1WHYS9X5j+iC2s2vUNR1sX/ysUzS7HQ/TY8GE1sWSKrAHq/4ftL6EpuTdaff2UOEAd2QWkiTcR7MP1kLTb6eowT1bX/p+P7sTRQS21C4Wnkcv/0xNJ8OtrmkbZEgrdTokjR3n4IdCheUaypqUIpiVaMARBCcSzhwt3Gy9BS5m/aW0o36QdeL1BZ5N8k4LdsV0ZK/fti+QLDkj2O0RP7O9UcNiAG+60eOMBZ3P37rEXjr6WOqvDw4y32rFYCV7J2O72YIjl6c6GhS03YAi4vp0AjompxbpBQKUYInuGo11Oeir1NekJnfZb2IkvAFEETmad soumya@UbuntuSR"
}*/

data "template_file" "init" {
  template = "${file("/opt/terraform/base/scripts/configure.sh")}"
}
/*
resource "aws_security_group" "nginx-sg" {
  name = "nginx-sg"
  vpc_id = "vpc-36c6b45e"

  # SSH access from anywhere
  ingress{
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from anywhere
  ingress{
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound internet access
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}*/


/*
resource "aws_s3_bucket" "remote_state" {
bucket = "${var.prefix}-remote-state"
acl = "authenticated-read"
versioning {
enabled = true
}
tags {
Name = "${var.prefix}-remote-state-01"
#Environment = "${var.environment}"
}
}*/
