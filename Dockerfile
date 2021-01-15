
#image
FROM debian:buster
COPY ./srcs/init.sh .
COPY ./srcs/nginx.conf ./tmp/
CMD bash init.sh & bash 

