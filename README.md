# ft_server

Description

ft_server is a project that asks you to run a server on Debian Buster through Docker with a Wordpress, Phpmyadmin and Mysql runnning.

Usage

# Build image
docker build -t ft_server .

# Build image with disabled autoindex
docker build --build-arg AUTOINDEX=off -t ft_server .

# Run image
docker run -it -p 80:80 -p 443:443 ft_server

Ressources

Set up LEMP server: [https://linuxconfig.org/how-to-set-up-a-lemp-server-on-debian-10-buster]
Install Wordpress (LEMP): [https://www.digitalocean.com/community/tutorials/how-to-install-wordpress-with-lemp-on-ubuntu-18-04]
Self signed SSL: [https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-nginx-on-debian-10]
Redirect http to https: [https://linuxize.com/post/redirect-http-to-https-in-nginx/]
Docker Best Practice: [https://docs.docker.com/develop/develop-images/dockerfile_best-practices/]
