#!/bin/bash

# install nginx
yum update -y
yum install -y wget
wget http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
rpm -ivh nginx-release-centos-7-0.el7.ngx.noarch.rpm
yum install -y nginx

# configure nginx
sudo su -c "cat /tmp/nginx.conf.updated > /etc/nginx/nginx.conf"

# start nginx service
service nginx start
chkconfig nginx on

# https://stackoverflow.com/questions/23948527/13-permission-denied-while-connecting-to-upstreamnginx?rq=1
# -p - persistent change
setsebool -P httpd_can_network_connect 1


# install jenkins
yum update -y
yum install -y java-1.8.0-openjdk wget
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
yum install -y jenkins
service jenkins start
chkconfig jenkins on

rm /tmp/nginx.conf.updated
rm /tmp/jenkins_server.sh
