data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


resource "aws_instance" "example" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
   #key_name                    = "my_key_pair"
  subnet_id                   = aws_subnet.my_subnet_public.id
  vpc_security_group_ids      = [aws_security_group.allow_trafic.id]
  availability_zone           = "eu-west-3a"
  associate_public_ip_address = true
  connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file("my_key_pair.pem")
    }
  tags = {
    Name = "jenkins_owner-instance_terraform"
  }

user_data = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y docker.io

    sudo wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
    sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
    curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee   /usr/share/keyrings/jenkins-keyring.asc > /dev/null
    echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
    https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null
    sudo apt-get update -y 
    # installation java 
    sudo dpkg --configure -a
    sudo apt-get install -f
    sudo apt-get clean
    sudo apt install -y openjdk-11-jre -y 
    #sudo update-alternatives --config java
    # Install Jenkins
    sudo apt-get update
    sudo apt-get install -y jenkins
    #configuration de port de jenkins 
    sudo sed -i 's/HTTP_PORT=8080/HTTP_PORT=9999/' /etc/default/jenkins
    sudo sed -i 's/Environment ="JENKINS_PORT=8080"/Environment="JENKINS_PORT=9999"' /lib/systemd/system/jenkins.service

    # Install AWS CLI
    apt-get install -y awscli

    # Install kubectl
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

    # Install eksctl
    curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
    mv /tmp/eksctl /usr/local/bin

    # Start Jenkins and Docker services
    systemctl start jenkins
    systemctl start docker
  EOF
}