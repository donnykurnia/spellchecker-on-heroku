FROM heroku/php
MAINTAINER Donny Kurnia <donnykurnia@gmail.com>

#install pspell
RUN mkdir -p /app/.heroku/aspell && \

    cd /app/user/src && \
    tar zxf aspell-0.60.6.1.tar.gz && \
    cd aspell-0.60.6.1 && \
    ./configure --prefix=/app/.heroku/aspell && \
    make install && \

    cd /app/user/src && \
    tar jxf aspell6-en-2015.04.24-0.tar.bz2 && \
    cd aspell6-en-2015.04.24-0 && \
    PATH=/app/.heroku/aspell/bin:$PATH ./configure && \
    make install && \

    cd /app/user/src && \
    tar jxf aspell5-da-1.4.42-1.tar.bz2 && \
    cd aspell5-da-1.4.42-1 && \
    PATH=/app/.heroku/aspell/bin:$PATH ./configure && \
    make install && \

    cd /app/user/src && \
    cd pspell && \
    phpize && \
    ./configure --with-pspell=/app/.heroku/aspell && \
    make && \
    make install && \
    make clean && \
    echo "extension=pspell.so" >> /app/.heroku/php/etc/php/conf.d/pspell.ini
