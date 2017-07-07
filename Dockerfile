FROM ubuntu:16.04
MAINTAINER elana laskin

# apt-get only allows packages which work in interactive mode. Set all packages to work in noninteractive mode.
ENV DEBIAN_FRONTEND noninteractive

# Avoid ERROR: invoke-rc.d: policy-rc.d denied execution of start.
RUN sed -i "s/^exit 101$/exit 0/" /usr/sbin/policy-rc.d

# to avoid this error: "Automatically disabled Acquire::http::Pipeline-Depth..."
RUN echo "Acquire::http::No-Cache true;" >> /etc/apt/apt.conf.d/99mysettings
RUN echo "Acquire::http::Pipeline-Depth 0;" >> /etc/apt/apt.conf.d/99mysettings

RUN apt-get update && apt-get -y install apt-utils \
    apache2 \
    git \
    libapache2-mod-php \
    libssl-dev \
    memcached \
    php \
    php-curl \
    php-intl \
    php-mbstring \
    php-mcrypt \
    php-soap \
    php-xml \
    php-xmlrpc \
    php-zip \
    php7.0-gd \
    vim

ADD moodle /tmp/moodle

RUN mv /tmp/moodle/* /var/www/html
RUN echo "ServerName 100.38.56.98" >> /etc/apache2/apache2.conf
RUN mkdir /var/moodledata
RUN chown -R www-data /var/moodledata
RUN chmod -R 777 /var/moodledata

EXPOSE 80
