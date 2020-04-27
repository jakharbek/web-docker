ARG PHP_VERSION
FROM php:${PHP_VERSION}
ARG HTTP_PROXY
ARG APP_ENV
ARG WITH_PNG_GD=0
ARG NODE_VERSION=13
ARG NPM_VERSION=6.13.0
ENV http_proxy ${HTTP_PROXY}
ENV https_proxy ${HTTP_PROXY}
ENV APP_ENV ${APP_ENV}

RUN apt-get update && \
    apt-get -y install \
        gnupg2 && \
    apt-key update && \
    apt-get update && \
    apt-get -y install \
            g++ \
            git \
            curl \
            cron \
            wget \
            supervisor \
            imagemagick \
            libcurl3-dev \
            libicu-dev \
            libfreetype6-dev \
            libjpeg-dev \
            libjpeg62-turbo-dev \
            libonig-dev \
            libmagickwand-dev \
            libpq-dev \
            libpng-dev \
            libxml2-dev \
            libzip-dev \
            zlib1g-dev \
            default-mysql-client \
            openssh-client \
            nano \
            unzip \
            libcurl4-openssl-dev \
            libssl-dev \
        --no-install-recommends && \
        apt-get clean && \
        rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


RUN if [ $WITH_PNG_GD = 1 ]; then \
        docker-php-ext-configure gd \
                --with-freetype-dir=/usr/include/ \
                --with-png-dir=/usr/include/ \
                --with-jpeg-dir=/usr/include/; \
    else \
        docker-php-ext-configure gd \
                --with-freetype=/usr/include/ \
                --with-jpeg=/usr/include/; \
    fi

# php install
RUN docker-php-ext-install \
                            soap \
                            zip \
                            curl \
                            bcmath \
                            exif \
                            gd \
                            iconv \
                            intl \
                            mbstring \
                            opcache \
                            pdo_mysql \
                            pdo_pgsql \
    && docker-php-ext-configure bcmath
RUN usermod -u 1000 www-data


#composer
RUN curl -sS https://getcomposer.org/installer | php -- \
        --filename=composer \
        --install-dir=/usr/local/bin
ENV COMPOSER_HOME /composer
ENV PATH /usr/local/bin:$PATH
ENV COMPOSER_ALLOW_SUPERUSER 1

#php
COPY ./docker/php/php.ini /usr/local/etc/php/
COPY ./docker/php/www.conf /usr/local/etc/php/

#supervisor
COPY ./docker/php/supervisord-php-fpm.conf /etc/supervisor/conf.d/
COPY ./docker/php/supervisord-cron.conf /etc/supervisor/conf.d/
COPY ./docker/php/supervisord.conf /etc/supervisor/

#crontab
ADD ./docker/php/crontab /etc/cron.d/crontab
RUN chmod 0644 /etc/cron.d/crontab
RUN touch /var/log/cron.log

# Node.js
RUN curl -sL https://deb.nodesource.com/setup_${NODE_VERSION}.x -o nodesource_setup.sh
RUN bash nodesource_setup.sh
RUN apt-get install nodejs -y
RUN npm install npm@${NPM_VERSION} -g
RUN command -v node
RUN command -v npm

#copy
COPY ./ /app

#init
WORKDIR /app

RUN chmod 777 ./initialize.sh

RUN if [ $APP_ENV = "dev" ]; then \
        ./init-dev.sh; \
    else \
        echo "prod"; \
    fi


EXPOSE 9000
EXPOSE 9005

CMD ["./initialize.sh"]