#!/usr/bin/env bash
pecl install xdebug
docker-php-ext-enable xdebug
wget https://cs.symfony.com/download/php-cs-fixer-v2.phar -O /bin/php-cs-fixer