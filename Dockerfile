FROM ubuntu:16.04

ENV DEBIAN_FRONTEND noninteractive

RUN mkdir -p /var/run/apache2 /var/lock/apache2

RUN apt-get update \
    && apt-get install -y \
    # Apache\PHP
    apache2 libapache2-mod-gnutls\
    # Build Deps
    build-essential curl make \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN a2enmod ssl \
    && a2enmod proxy \
    && a2enmod proxy_http \
    && a2enmod proxy_ajp \
    && a2enmod rewrite \
    && a2enmod deflate \
    && a2enmod headers \
    && a2enmod proxy_balancer \
    && a2enmod proxy_connect \
    && a2enmod proxy_html

#RUN a2dissite 000-default

# Apache Config
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_RUN_DIR /var/run/apache2
ENV APPLICATION_ENV local

#COPY apache2/apache2.conf /etc/apache2/

COPY sites-enabled/000-default.conf /etc/apache2/sites-enabled/000-default.conf
COPY apache2-foreground /usr/local/bin/

ENV SERVER_NAME=localhost
ENV APACHE_RUN_USER=www-data
ENV APACHE_RUN_GROUP=www-data
ENV APACHE_PID_FILE=/var/run/apache2/apache2.pid
ENV APACHE_RUN_DIR=/var/run/apache2
ENV APACHE_LOCK_DIR=/var/lock/apache2
ENV APACHE_LOG_DIR=/var/log/apache2
ENV APACHE_LOG_LEVEL=warn
ENV APACHE_CUSTOM_LOG_FILE=/proc/self/fd/1
ENV APACHE_ERROR_LOG_FILE=/proc/self/fd/2

CMD ["bash","/usr/local/bin/apache2-foreground"]
