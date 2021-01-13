
#image
FROM debian:buster
COPY ./srcs/init.sh .
COPY ./srcs/nginx.conf ./bin/
CMD bash init.sh &bash


