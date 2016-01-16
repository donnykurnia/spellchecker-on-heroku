FROM heroku/php
MAINTAINER Donny Kurnia <donnykurnia@gmail.com>

#install pspell
RUN apt-get update && \
    apt-get install -y libaspell-dev libpspell-dev aspell aspell-en aspell-da && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean && \
    cd pspell && \
    phpize && \
    ./configure && \
    make && \
    make install && \
    echo "extension=pspell.so" >> /app/.heroku/php/etc/php/conf.d/pspell.ini
