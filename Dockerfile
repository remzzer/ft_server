#Get image
FROM debian:buster

#Copy sources
COPY ./srcs/init.sh .
COPY ./srcs/test.html ./tmp/
COPY ./srcs/nginx.conf ./tmp/
COPY ./srcs/wp-config.php ./tmp/
COPY ./srcs/config.inc.php ./tmp/

#Set autoindex
ENV AUTOINDEX on

#Launch Script
CMD bash init.sh & bash 

#Desactivate autoindex while running the container
#docker run -d -p 80 -p 443 IMAGE_NAME -e AUTOINDEX=off
  
