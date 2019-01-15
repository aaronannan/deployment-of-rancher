provider "aws" {

access_key = "AKIAIW4OYMKDT5GEXIBA"
secret_key = "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"
region = us-east-1
}

resource "aws_instance" "rancher" {
ami = "ami-06af601d319a5b99b"
instance_type = "t2.micro"
}

provisioner "local-exec" {
   command = "echo ${aws_instance.rancher.private_ip} >> private_ips.txt"
   }
   
output "ip" {
 value = ${aws_instance.rancher.public_ip}"
 }
 
 tag "name" {
  value = "Rancher"
  }
   
