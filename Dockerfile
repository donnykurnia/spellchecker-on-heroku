FROM heroku/php
MAINTAINER Donny Kurnia <donnykurnia@gmail.com>

#install pspell
RUN mkdir -p /app/.heroku/root && \

    apt-get update && \
    apt-get install -y aspell-en aspell-da libpspell-dev && \

    for f in `dpkg -L libpspell-dev       | grep -v '\/\.'`; do if [ -f $f ]; then cp --parents $f /app/.heroku/root; fi done && \
    for f in `dpkg -L aspell              | grep -v '\/\.'`; do if [ -f $f ]; then cp --parents $f /app/.heroku/root; fi done && \
    for f in `dpkg -L aspell-en           | grep -v '\/\.'`; do if [ -f $f ]; then cp --parents $f /app/.heroku/root; fi done && \
    for f in `dpkg -L aspell-da           | grep -v '\/\.'`; do if [ -f $f ]; then cp --parents $f /app/.heroku/root; fi done && \
    for f in `dpkg -L dictionaries-common | grep -v '\/\.'`; do if [ -f $f ]; then cp --parents $f /app/.heroku/root; fi done && \
    for f in `dpkg -L libaspell-dev       | grep -v '\/\.'`; do if [ -f $f ]; then cp --parents $f /app/.heroku/root; fi done && \
    for f in `dpkg -L libaspell15         | grep -v '\/\.'`; do if [ -f $f ]; then cp --parents $f /app/.heroku/root; fi done && \
    for f in `dpkg -L libtext-iconv-perl  | grep -v '\/\.'`; do if [ -f $f ]; then cp --parents $f /app/.heroku/root; fi done && \

    rm -rf /var/lib/apt/lists/* && \
    apt-get clean && \

    cd /app/user/src && \
    cd pspell && \
    phpize && \
    ./configure --with-pspell=/app/.heroku/root/usr && \
    make && \
    make install && \
    make clean && \
    echo "extension=pspell.so" >> /app/.heroku/php/etc/php/conf.d/pspell.ini
