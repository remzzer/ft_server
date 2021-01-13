#[Basic command update]	
apt update -y && apt upgrade -y
apt wget

#[SETTING USER ENV]	
mkdir /var/www/localhost
chown -R www-data:www-data /var/www/* 
chmod -R 755 /var/www/* 

#[INSTALL NGINX]
apt install -y nginx
service nginx start

#[SETTING NGINX SERVER]
mv /bin/nginx.conf /etc/nginx/sites-available/
rm -rf /etc/nginx/sites-available/default
rm -rf /etc/nginx/sites-enabled/default
ln -s /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled/

#[INSTALL PHP]
apt install -y php-fpm php-mysql
service php-fpm start

#[SETTING PH]
touch /var/www/info.php
echo "<?php
  phpinfo();
?>" > /var/www/localhost/info.php

