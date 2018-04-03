output "jenkins_server_id" {
  value = "${aws_instance.jenkins_server.id}"
}

output "jenkins_server_dns" {
  value = "${aws_instance.jenkins_server.public_dns}"
}

output "initialAdminPassword_manual_receiving_steps" {
  value = "\nssh -i ${var.aws_key_pair_private_key_path} -oStrictHostKeyChecking=no centos@${aws_instance.jenkins_server.public_dns}\nsudo cat /var/lib/jenkins/secrets/initialAdminPassword"
}

output "ssh_connection_template" {
  value = "ssh -i ${var.aws_key_pair_private_key_path} -oStrictHostKeyChecking=no centos@${aws_instance.jenkins_server.public_dns}"
}
