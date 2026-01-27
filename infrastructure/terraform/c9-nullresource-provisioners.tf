resource "null_resource" "bastion_ready" {
    depends_on = [ 
        module.ec2_public
     ] //depends on IGW module to provide internet to the bastion host

    connection {
        type = "ssh"
        user = "ec2-user"
        host = aws_eip.bastion_eip.public_ip
        private_key = file(local.ssh_private_key_path)
    }
  
  #file provisioner to copy file from local machine to remote machine
  provisioner "file" {
    source      = local.ssh_private_key_path
    destination = "/tmp/terraform-aws.pem"
  }

  #remote-exec provisioner to run commands on remote machine
  provisioner "remote-exec" {
    inline = [
      "chmod 400 /tmp/terraform-aws.pem",
      "sudo mv /tmp/terraform-aws.pem /home/ec2-user/.ssh/terraform-aws.pem",
      "sudo chown ec2-user:ec2-user /home/ec2-user/.ssh/terraform-aws.pem"
    ]
  }

  #local-exec provisioner to run commands on local machine
  provisioner "local-exec" {
    interpreter = [ "/bin/bash", "-c" ]
    command = "mkdir -p ${path.module}/local-exec-output-files"

  }
  provisioner "local-exec" {
    interpreter = [ "/bin/bash", "-c" ]
    working_dir = "${path.module}/local-exec-output-files/"
    command = "echo Bastion Host is ready on $(date) and you can connect using the following command: ssh -i ${local.ssh_private_key_path} ec2-user@${aws_eip.bastion_eip.public_ip} >> bastion-connection-info.txt"
    //on_failure = continue
  }


  //provisioner "local-exec" {
  //  command = "echo Destroy time prov `date` >> /tmp/destroy-time.txt"
  //  working_dir = "local-exec-output-files/"
  //  when = destroy
  //}
}



