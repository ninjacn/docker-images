FROM php:7.4-fpm-alpine
MAINTAINER "ninjacn" <x@ninjacn.com>
# e.g. docker build -t ninjacn/laravel-fpm-7.4 .
# e.g. docker build -t registry.cn-beijing.aliyuncs.com/pengmingtech/laravel-fpm-7.4 .

# Install dev dependencies
RUN apk add --no-cache --virtual .build-deps \
    curl-dev \
    imagemagick-dev \
    libtool \
    libxml2-dev \
    postgresql-dev \
    sqlite-dev

# Install production dependencies
RUN apk add --no-cache \
    bash \
    curl \
    freetype-dev \
    g++ \
    gcc \
    git \
    icu-dev \
    icu-libs \
    imagemagick \
    libc-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    libzip-dev \
    make \
    mysql-client \
    nodejs \
    nodejs-npm \
    oniguruma-dev \
    yarn \
    openssh-client \
    postgresql-libs \
    rsync \
    zlib-dev

RUN apk add --no-cache \
    autoconf

# Install PECL and PEAR extensions
RUN pecl install \
    redis \
    imagick \
    xdebug

# Enable PECL and PEAR extensions
RUN docker-php-ext-enable \
    redis \
    imagick \
    xdebug

# Configure php extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg

# Install php extensions
RUN docker-php-ext-install \
    bcmath \
    calendar \
    curl \
    exif \
    gd \
    iconv \
    intl \
    mbstring \
    pdo \
    pdo_mysql \
    pdo_pgsql \
    pdo_sqlite \
    pcntl \
    tokenizer \
    xml \
    zip

# Install php extensions
RUN docker-php-ext-install \
    mysqli


# Install composer
ENV COMPOSER_HOME /composer
ENV PATH ./vendor/bin:/composer/vendor/bin:$PATH
ENV COMPOSER_ALLOW_SUPERUSER 1
RUN curl -s https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer

# Install PHP_CodeSniffer
RUN composer global require "squizlabs/php_codesniffer=*"

RUN apk add --no-cache \
    busybox-extras

# Install PECL and PEAR extensions
RUN pecl install \
    mongodb

# Enable PECL and PEAR extensions
RUN docker-php-ext-enable \
    mongodb

# Cleanup dev dependencies
RUN apk del -f .build-deps

# Setup working directory
WORKDIR /var/www/html

#CMD ["php", "artisan", "serve"]
#EXPOSE 8000
