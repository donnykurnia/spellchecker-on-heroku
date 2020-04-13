FROM php:7.4.4-apache as php-build

ENV PORT 3000

#install pspell
RUN apt-get update && \
    apt-get install -y libpspell-dev && \
    docker-php-ext-configure pspell && \
    docker-php-ext-install -j$(nproc) pspell && \
    docker-php-ext-enable pspell

CMD sed -i "s/80/$PORT/g" /etc/apache2/sites-available/000-default.conf /etc/apache2/ports.conf && \
    docker-php-entrypoint apache2-foreground

COPY --from=composer /usr/bin/composer /usr/bin/composer
COPY . /var/www/html

FROM php-build
MAINTAINER Donny Kurnia <donnykurnia@gmail.com>

ENV PATH /usr/local/sbin:/usr/sbin:/sbin:$PATH

RUN useradd -m php && \
    chown -R php /var/www/html /etc/apache2/
WORKDIR  /var/www/html
USER php
RUN composer install
