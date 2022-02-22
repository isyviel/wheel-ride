FROM php:8.1-apache

# Install PHP
RUN apt-get update \
   && apt-get install -y \
    locales \
    apt-utils \
    git \
    libicu-dev \
    g++ \
    libpng-dev \
    libxml2-dev \
    libzip-dev \
    libonig-dev \
    libxslt-dev \
    libcurl4-openssl-dev \
    pkg-config \
    libssl-dev

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install Symfony CLI
RUN curl -sS https://get.symfony.com/cli/installer | bash
RUN mv /root/.symfony/bin/symfony /usr/local/bin/symfony

WORKDIR /var/www/

# Usefull PHP pecl packages
RUN docker-php-ext-configure intl
RUN docker-php-ext-install gd opcache intl zip calendar dom mbstring gd xsl pdo_mysql
RUN docker-php-ext-enable pdo_mysql

# Configuration
COPY php.ini /usr/local/etc/php/conf.d
COPY host/wride.conf /etc/apache2/sites-available/wride.conf

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf &&\
    a2enmod rewrite &&\
    a2dissite 000-default &&\
    a2ensite wride &&\
    service apache2 restart

# Install Nodejs
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash \
      && apt-get install -y nodejs \
