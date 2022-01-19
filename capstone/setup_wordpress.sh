#!/bin/bash

sudo su
#The EPEL repository is an additional package repository that provides easy access to install packages for commonly used software
amazon-linux-extras install epel -y

yum update -y

yum install -y java-1.8.0-openjdk-devel 
# Install httpd (Apache server)
yum install httpd -y
service httpd start

# Install PHP for wordpress
amazon-linux-extras enable php7.2
yum clean metadata
yum install php-cli php-pdo php-fpm php-json php-mysqlnd

# Install Mysql
yum install mysql -y

# Install Wordpress
cd /var/www/html
wget http://wordpress.org/latest.tar.gz
tar -xzvf latest.tar.gz
mv wordpress/* .
rmdir wordpress
# mv wp-config-sample.php wp-config.php