provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_instance" "jenkins_server" {
  ami                    = "${var.aws_instance_ami}"
  instance_type          = "${var.aws_instance_type}"
  vpc_security_group_ids = ["${aws_security_group.jenkins_sg.id}"]

  key_name = "${aws_key_pair.jenkins_ssh.key_name}"

  connection {
    user        = "centos"
    private_key = "${file(var.aws_key_pair_private_key_path)}"
  }

  provisioner "file" {
    content     = "${file(format("%v%v", path.module, "/files/conf.nginx"))}"
    destination = "/tmp/nginx.conf.updated"
  }

  provisioner "file" {
    content     = "${file(format("%v%v", path.module, "/files/jenkins_server.sh"))}"
    destination = "/tmp/jenkins_server.sh"
  }

  provisioner "file" {
    content     = "${file(format("%v%v", path.module, "/files/jenkins_password.sh"))}"
    destination = "/tmp/jenkins_password.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/jenkins_server.sh",
      "chmod +x /tmp/jenkins_password.sh",
      "sudo bash /tmp/jenkins_server.sh",
      "sudo su -c 'SHOW_JENKINS_PASSWORD=${var.show_jenkins_password} bash /tmp/jenkins_password.sh'",
    ]
  }

  tags {
    Name = "${var.aws_instance_name}${var.attach_test_uids == 1 ? md5(timestamp()) : ""}"
  }
}

resource "aws_security_group" "jenkins_sg" {
  name = "${var.aws_security_group_name}${var.attach_test_uids == 1 ? md5(timestamp()) : ""}"

  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  # nginx as a proxy
  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.aws_security_group_name}${var.attach_test_uids == 1 ? md5(timestamp()) : ""}"
  }
}

resource "aws_key_pair" "jenkins_ssh" {
  key_name   = "${var.aws_key_pair_name}${var.attach_test_uids == 1 ? md5(timestamp()) : ""}"
  public_key = "${file(var.aws_key_pair_public_key_path)}"
}
