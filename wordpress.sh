#!/bin/bash
sudo yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y
sudo yum-config-manager --enable remi-php72
sudo yum install httpd wget mysql php php-mysql unzip -y
sudo systemctl start httpd
sudo systemctl enable httpd
sudo wget https://wordpress.org/latest.zip
sudo unzip latest.zip
sudo rsync -a wordpress/ /var/www/html
sudo rm -rf latest.zip* wordpress
sudo chown -R apache:apache /var/www/html
sudo setenforce 0
sudo sed s/SELINUX=enforcing/SELINUX=disabled/g  /etc/sysconfig/selinux -i
sudo systemctl restart httpd