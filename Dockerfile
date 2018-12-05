FROM php:7.2-fpm

RUN pecl install -o -f redis \
&&  rm -rf /tmp/pear \
&&  docker-php-ext-enable redis

RUN DEBIAN_FRONTEND=noninteractive apt-get update -q \
    && apt-get install -y --no-install-recommends apt-utils

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libcurl4-nss-dev \
        libicu-dev \
        libxslt-dev \
    && apt-get install -y \
    && apt-get install -y unzip \
    libxml2-dev \
    && docker-php-ext-install soap \
    && docker-php-ext-install iconv \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && docker-php-ext-install curl \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install pdo pdo_mysql \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install json \
    && docker-php-ext-install xsl \
    && docker-php-ext-install zip \
    && docker-php-ext-install opcache \
    && apt-get install -y zlib1g-dev libicu-dev g++ \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl \
    && apt-get install -y vim \
    && apt-get install -y git \
    && docker-php-ext-install bcmath \
    && docker-php-ext-install ctype \
    && docker-php-ext-install dom \
    && docker-php-ext-install hash

RUN curl -s https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer --version
RUN pecl install xdebug
RUN docker-php-ext-enable xdebug

RUN apt-get -y install cron

# Add crontab file in the cron directory
# ADD crontab /etc/cron.d/hello-cron

# Give execution rights on the cron job
# RUN chmod 0644 /etc/cron.d/hello-cron

# Create the log file to be able to run tail
# RUN touch /var/log/cron.log

# Run the command on container startup
#CMD cron && tail -f /var/log/cron.log
