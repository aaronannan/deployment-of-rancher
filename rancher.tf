provider "aws" {

access_key = ""
secret_key = ""
region = us-east-1
}


resource "aws_instance" "rancher" {
ami = "ami-06af601d319a5b99b"
instance_type = "t2.micro"
   
   tags = {
   Name = "Rancher"
  }

   
provisioner "local-exec" {
   command = "echo ${aws_instance.rancher.private_ip} >> private_ips.txt"
   }
   
   provisioner "file" {
    source      = "rancher.sh"
    destination = "/tmp/rancher.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/rancher.sh",
      "/tmp/rancher.sh args",
    ]
  }
   
}

   
output "ip" {
 value = ${aws_instance.rancher.public_ip}"
 }
 
