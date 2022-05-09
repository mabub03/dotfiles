sudo apt update && sudo apt upgrade
# if on nvidia install nvidia drivers also
sudo apt install build-essential \
  unzip \
  zip \
  zsh \
  clang \
  cmake \
  python3 \
  python3-pip \
  ninja-build \
  pkg-config \
  wl-clipboard \
  openjdk-8-jdk \
  libgtk-3-dev\
  python-dev \
  python3-dev \

curl https://get.volta.sh | bash
# install volta stable node with 
volta install node
# install latest node with 
# volta install node@latest

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
sudo cp nvim.appimage /usr/bin/nvim
sudo chmod +777 /usr/bin/nvim

# sql lsp server gave issues
$HOME/dotfiles/setup_nvim.sh

# install lamp
# sudo apt install apache2 \
#  php7.4 \
#  php7.4-mysql \
#  php-common \
#  php7.4-cli \
#  php7.4-json \
#  php7.4-common \
#  php7.4-opcache \
#  libapache2-mod-php7.4 \
#  php7.4-mbstring \
#  php7.4-xml \
#  php7.4-curl \
#  php7.4-zip \
#  mariadb-server \
#  mariadb-client \
#  openssl \
#  phpmyadmin \

# sudo systemctl enable apache2
#sudo service apache2 start

# sudo systemctl enable mariadb
#sudo service mysql start

#sudo mysql_secure_installation

echo "load the setup zsh script if you want to use zsh"

# IMPORTANT INFORMATION
# to use root account in phpmyadmin:
# sudo mysql
# USE mysql;
# UPDATE user SET plugin='' WHERE user='root';
# FLUSH PRIVILEGES;
# EXIT

# and login to database from cli like this: 
# sudo mysql -u root -p

# add to /etc/apache2/apache2.conf.conf 
# Include /etc/phpmyadmin/apache.conf
# P@$$w0rd is the password


# ========== This setup doesn't get signed by your browser's trusted certificate authorities so you will get a conn not private error ==========
# create and sign openssl key 
# sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/apache-selfsigned.key -out /etc/ssl/certs/apache-selfsigned.crt
# -x509 tells the utility to make a self-signed certificate instead of generating a certificate signing request
# - nodes skips the option to secure certificates with a passphrase (need apache to read the files without user intervention when server starts up, and passphrase stops this from happening)
# -days 365 sets the length of time the certificate is valid, the 365 sets it for a year
# -newkey rsa:2048 specifices we want to generate a new certificate and a new key at the same time (didn't create the key before so creates it at the same time as the certifcate gets created) and rsa:2048 means to make a RSA key that is 2048 bits long 
# -keyout tells opessl where to place the generated public key that is being created
# -out tells openssl where to place the certificate that is being created

# ssql security settings in /etc/apache2/conf-available/ssl-params.conf
#SSLCipherSuite EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:AES256+EDH
#SSLProtocol All -SSLv2 -SSLv3 -TLSv1 -TLSv1.1
#SSLHonorCipherOrder On
# Disable preloading HSTS for now.  You can use the commented out header line that includes
# the "preload" directive if you understand the implications.
# Header always set Strict-Transport-Security "max-age=63072000; includeSubDomains; preload"
#Header always set X-Frame-Options DENY
#Header always set X-Content-Type-Options nosniff
# Requires Apache >= 2.4
#SSLCompression off
#SSLUseStapling on
#SSLStaplingCache "shmcb:logs/stapling-cache(150000)"
# Requires Apache >= 2.4.11
#SSLSessionTickets Off

# change ServerAdmin, ServerName, SSLCertificateFile path, and SSLCertificateKeyFile path, in /etc/apache2/sites-available/default-ssl.conf

# modify the http host file to redirect to https in /etc/apache2/sites-available/000-default.conf
#<VirtualHost *:80>
#        . . .
#
#        Redirect "/" "https://your_domain_or_IP/"
#
#        . . .
#</VirtualHost>

# Adjust the firewall 
# sudo ufw app list
# sudo ufw status 
# sudo ufw allow 'Apache Full'
# sudo ufw delete allow 'Apache'
# sudo ufw status

# Enable the changes in Apache 
# sudo a2enmod ssl 
# sudo a2enmod headers 
# sudo a2ensite default-ssl 
# sudo a2enconf ssl-params 
# sudo apache2ctl configtest 
# sudo systemctl restart apache2 

# this message tells you that ServerName isn't set globally if you want to get rid of that message you can set ServerName to your server's domain name or ip address in /etc/apache2/apache2.conf
# AH00558: apache2: Could not reliably determine the server's fully qualified domain name, using 127.0.1.1. Set the 'ServerName' directive globally to suppress this message
# Syntax OK

# Test encryption by going to http://server_domain_or_IP or https://server_domain_or_IP

# if redirect work correctly you can set permanent redirect to only allow encrypted traffic
# Change to a permanent redirct in /etc/apache2/sites-available/000-default.conf
#<VirtualHost *:80>
#        . . .
#
#        Redirect permanent "/" "https://your_domain_or_IP/"
#
#        . . .
#</VirtualHost>
#sudo apache2ctl configtest 
#sudo systemctl restart apache 2
