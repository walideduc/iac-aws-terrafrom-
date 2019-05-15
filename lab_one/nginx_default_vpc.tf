##################################################################################
# VARIABLES
##################################################################################

variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_regin" {
    default="eu-west-3"
}
variable "private_key_path" {}
variable "key_name" {
  default = "Waled-MacBook-Pro"
}


##################################################################################
# PROVIDERS
##################################################################################

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_regin}"
}


##################################################################################
# RESOURCES
##################################################################################

resource "aws_instance" "nginx" {
    ami           = "ami-0ebc281c20e89ba4b"
    instance_type = "t2.micro"
    key_name        = "${var.key_name}"

    connection {
        user        = "ec2-user"
        private_key = "${file(var.private_key_path)}"
    }
    provisioner "remote-exec" {
        inline = [
        "sudo yum install nginx -y",
        "sudo service nginx start"
        ]
    }
}

##################################################################################
# OUTPUT
##################################################################################

output "aws_instance_public_dns" {
    value = "${aws_instance.nginx.public_dns}"
}
output "availability_zone" {
  value = "${aws_instance.nginx.availability_zone}"
}
