resource "aws_instance" "jenkins" {
  ami           = var.AMI
  instance_type = "t2.medium"

  # the VPC subnet
  subnet_id = aws_subnet.main-public.id

  # the security group
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]

  # the public SSH key
  key_name = aws_key_pair.mykeypair.key_name

  tags = {
    Name = var.instance_name
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update –y",
      "sudo yum -y install wget",
      "sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo",
      "sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key",
      "sudo yum upgrade -y",
      "sudo dnf install java-17-amazon-corretto -y",
      "sudo yum install jenkins -y",
      "sudo systemctl enable jenkins",
      "sudo systemctl start jenkins",
      "sudo yum install docker -y",
      "sudo systemctl start docker",
      "sudo systemctl enable docker",
      "sudo usermod -a -G docker $(whoami)",
      "curl -o kubectl https://s3.us-west-2.amazonaws.com/amazon-eks/1.22.6/2022-03-09/bin/linux/amd64/kubectl",
      "chmod +x ./kubectl",
      "mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin",
      "echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc",
      "curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 > get_helm.sh",
      "chmod 700 get_helm.sh",
      "./get_helm.sh"
    ]
  }
  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file(var.PATH_TO_PRIVATE_KEY)
  }
}