#image
FROM debian:buster
COPY ./srcs/init.sh .
COPY ./srcs/test.html ./tmp/
COPY ./srcs/nginx.conf ./tmp/
COPY ./srcs/wp-config.php ./tmp/
COPY ./srcs/config.inc.php ./tmp/
CMD bash init.sh & bash 

