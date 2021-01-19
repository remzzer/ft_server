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

#[TESTING PHP]
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
echo "update mysql.user set plugin='mysql_native_password' where user='root';" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root

#[INSTALL WORDPRESS]
apt install -y wget
cd tmp/
wget -c https://wordpress.org/latest.tar.gz
tar -xzvf latest.tar.gz && rm latest.tar.gz
mv wordpress/ /var/www/localhost
mv /tmp/wp-config.php /var/www/localhost/wordpress

#[INSTALL PHPMYADMIN]
mkdir /var/www/localhost/phpmyadmin
apt install -y php-json php-mbstring
wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
tar -xvzf phpMyAdmin-4.9.0.1-all-languages.tar.gz --strip-components 1 -C /var/www/localhost/phpmyadmin

#[SETTING PHPMYADMIN]
mv /tmp/config.inc.php /var/www/localhost/phpmyadmin/

#[SETTING USER ACCESS RIGHT]
chown -R www-data:www-data /var/www/* 
chmod -R 755 /var/www/* 

#[SET AUTOINDEX]
if [ $VAL = off ]
then 
	sed -i 's/autoindex on/autoindex off/' /etc/nginx/sites-available/nginx.conf
fi	

service nginx start
