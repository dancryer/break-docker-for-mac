FROM ubuntu:16.04

ENV DEBIAN_FRONTEND noninteractive
RUN locale-gen en_GB.UTF-8

RUN apt-get update && apt-get install -y software-properties-common
RUN /usr/bin/add-apt-repository ppa:nginx/stable
RUN apt-get update && apt-get install -y --allow-unauthenticated nginx php7.0 php7.0-cli php7.0-fpm php7.0-opcache php-apcu supervisor

RUN rm -f /etc/nginx/sites-enabled/* && rm -f /etc/php/7.0/fpm/pool.d/*.conf
RUN mkdir /run/php && chmod -fv 0777 /run/php
RUN sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php/7.0/fpm/php-fpm.conf
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN mkdir /www

COPY nginx.conf /etc/nginx/sites-enabled/default
COPY phpfpm.conf /etc/php/7.0/fpm/pool.d/www.conf
COPY supervisor.conf /etc/supervisord.conf
COPY start.sh /root/start.sh

VOLUME /www

EXPOSE 80

CMD ["/bin/bash", "/root/start.sh"]