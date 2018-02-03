FROM heroku/php
LABEL maintainer Donny Kurnia <donnykurnia@gmail.com>

ENV PATH /app/.heroku/php/bin:/app/.heroku/php/sbin:/app/.heroku/aspell/bin:$PATH

#install pspell
RUN mkdir -p /app/.heroku/aspell && \
    cd /app/user/src && \
    tar zxf aspell-0.60.6.1.tar.gz && \
    cd aspell-0.60.6.1 && \
    ./configure --prefix=/app/.heroku/aspell && \
    make install

RUN cd /app/user/src && \
    tar jxf aspell6-en-2015.04.24-0.tar.bz2 && \
    cd aspell6-en-2015.04.24-0 && \
    ./configure && \
    make install

RUN cd /app/user/src && \
    tar jxf aspell5-da-1.4.42-1.tar.bz2 && \
    cd aspell5-da-1.4.42-1 && \
    ./configure && \
    make install

RUN cd /app/user/src && \
    cd pspell && \
    phpize && \
    ./configure --with-pspell=/app/.heroku/aspell && \
    make && \
    make install && \
    make clean && \
    echo "extension=pspell.so" >> /app/.heroku/php/etc/php/conf.d/pspell.ini

RUN useradd -m php && \
    find /app/.heroku/php -type d -exec chmod o+rx {} \; && \
    chown php vendor/heroku/heroku-buildpack-php/conf/nginx/* && \
    chmod o+rx /app/.heroku/php/sbin/nginx && \
    chmod o+r /app/.heroku/php/etc/nginx/* && \
    chmod o+w /app/.heroku/php/var/log/nginx /app/.heroku/php/var/run/nginx /app/.heroku/php/var/run

USER php

CMD  ["vendor/bin/heroku-php-nginx", "."]

WORKDIR /app/user

