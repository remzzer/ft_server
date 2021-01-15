#[Basic command update]	
apt update -y && apt upgrade -y

#[INSTALL NGINX]
apt install -y nginx

#[SETTING USER ENV]	
mkdir -p /var/www/localhost

#[SETTING NGINX SERVER]
mv /tmp/nginx.conf /etc/nginx/sites-available/
mv /tmp/test.html /var/www/localhost/
rm /etc/nginx/sites-available/default
rm /etc/nginx/sites-enabled/default
ln -s /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled/

#[SSL CERTIFICATE]
apt install -y openssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/localhost.key -out /etc/ssl/certs/localhost.crt -subj "/C=FR/ST=Paris/L=Paris/O=42/OU=42/CN=localhost"

#[SETTING PH]
touch /var/www/localhost/info.php
echo "<?php
  phpinfo();
?>" > /var/www/localhost/info.php

#[INSTALL PHP]
apt install -y php7.3-fpm php7.3-mysql
service php7.3-fpm start

#[INSTALL MARIADB]
apt install -y mariadb-server
service mysql start
#Connect as Root user w/ no pwd & create database
echo "CREATE DATABASE wordpress" | mysql -u root
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root@localhost';" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root

#[INSTALL WORDPRESS]
apt install -y wget
cd tmp/
wget -c https://wordpress.org/latest.tar.gz
tar xzvf latest.tar.gz && rm latest.tar.gz
mv wordpress/ /var/www/localhost/

#[SETTING USER ACCESS RIGHT]
chown -R www-data:www-data /var/www/* 
chmod -R 755 /var/www/* 

service nginx start
