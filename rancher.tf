resource "aws_key_pair" "rancher-key" {
 key_name = "rancher-key"
 public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}

resource "aws_instance" "rancher" {
 ami = "ami-03a935aafa6b52b97"
 instance_type = "t2.micro"
 key_name = "${aws_key_pair.rancher-key.key_name}"  
    
   provisioner "file" {
    source = "rancher.sh"
    destination = "/tmp/rancher.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/rancher.sh",
      "sudo /tmp/rancher.sh"
    ]
  }

 connection {
       user ="${var.INSTANCE_USERNAME}"
       private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
   }
}

 

