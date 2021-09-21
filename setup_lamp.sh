#!/bin/bash
sudo dnf install -y \
  httpd \
  mariadb \
  mariadb-server \
  php \
  php-common \
  php-pdo_mysql \
  php-pdo \
  php-gd \
  php-mbstring \
  php-cli \
  php-php-gettext \
  php-mbstring \
  php-mcrypt \
  php-mysqlnd \
  php-pear \
  php-curl \
  php-gd \
  php-xml \
  php-bcmath \
  php-zip \
  perl \
  perl-Net-SSLeay \
  openssl \
  perl-IO-Tty \
  perl-Encode-Detect \
  phpMyAdmin

sudo systemctl enable httpd
sudo systemctl start httpd
sudo systemctl enable mariadb
sudo systemctl start mariadb

sudo mysql_secure_installation
sudo systemctl restart mariadb

# To use PhpMyAdmin you can't use root and have to use a diferent user
# To do that go to mysql and enter:
# CREATE USER '<username>'@'%' IDENTIFIED BY '<password>';
# GRANT ALL PRIVILEGES ON *.* TO '<user>'@'%' WITH GRANT OPTION;

# gives you a gui command center for your server so you don't need to keep editing files in the terminal
# if you can't log in run this command: sudo /usr/libexec/webmin/changepass.pl /etc/webmin root <new-password>
# to restart webmin: sudo /etc/init.d/webmin restart
# wget http://www.webmin.com/download/rpm/webmin-current.rpm
# sudo rpm -U webmin-current.rpm

# Edit Firewall to add the proper services and ports
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https
sudo firewall-cmd --permanent --add-service=mysql
# Enable if you are using webmin
# sudo firewall-cmd --permanent --add-port=10000/tcp
sudo firewall-cmd --permanent --add-port=3306/tcp
sudo firewall-cmd --permanent --add-port=80/tcp
sudo firewall-cmd --reload

# be able to edit your files without being root in /var/www
sudo chmod -R 777 /var/www

# can manage server remotely on:
# https://yourip:10000

# if installed on your own machine and not a remote server then access with:
# https://localhost:10000
