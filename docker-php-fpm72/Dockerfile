FROM ninjacn/docker-centos7:latest
MAINTAINER "ninjacn" <x@ninjacn.com>

COPY ./files/php-7.2.16.tar.gz /tmp/
RUN cd /tmp && mkdir -p php_src \
    && tar -zxf php-7.2.16.tar.gz -C php_src --strip-components=1 \
    && rm php-7.2.16.tar.gz \
    && ( \
        cd php_src \
        && ./configure \
        --prefix=/opt/php \
        --enable-fpm \
        --with-fpm-user=root \
        --with-fpm-group=root \
        --with-config-file-path=/opt/php/etc \
        --with-openssl \
        --with-zlib \
        --enable-bcmath \
        --with-curl \
        --with-bz2 \
        --enable-exif \
        --enable-ftp \
        --with-gd \
        --with-freetype-dir \
        --with-jpeg-dir \
        --with-gettext \
        --enable-intl \
        --enable-mbstring \
        --with-mcrypt \
        --with-mysqli=mysqlnd \
        --enable-opcache \
        --with-pdo-mysql=mysqlnd \
        --enable-mysqlnd \
        --enable-soap \
        --enable-sockets \
        --enable-zip \
        --enable-calendar \
        --enable-dba \
        --with-mhash \
        --enable-pcntl \
        --enable-shmop \
        --enable-sysvmsg \
        --enable-sysvsem \
        --enable-sysvshm \
        --enable-wddx \
        && make \
        && make install \
    )

RUN /opt/php/bin/pecl install redis

RUN ln -s /opt/php/bin/php /usr/bin/php \
    && cp /opt/php/etc/php-fpm.conf.default /opt/php/etc/php-fpm.conf \
    && cp /opt/php/etc/php-fpm.d/www.conf.default /opt/php/etc/php-fpm.d/www.conf \
    && cd /tmp/php_src \
    && cp php.ini-production /opt/php/etc/php.ini \
    && rm -rf /tmp/php_src

RUN curl -sS https://getcomposer.org/installer | /opt/php/bin/php && \
	mv composer.phar /usr/local/bin/composer && \
	composer self-update

RUN sed -i '/^listen = /clisten = 0.0.0.0:9000' /opt/php/etc/php-fpm.d/www.conf
RUN sed -i '/^listen.allowed_clients/c;listen.allowed_clients =' /opt/php/etc/php-fpm.d/www.conf
RUN sed -i '/^user =/cuser = root' /opt/php/etc/php-fpm.d/www.conf
RUN sed -i '/^group =/cgroup = root' /opt/php/etc/php-fpm.d/www.conf
RUN sed -i '/^pm.max_children/cpm.max_children = 16' /opt/php/etc/php-fpm.d/www.conf
RUN sed -i '/^;date.timezone =/cdate.timezone = Asia/Shanghai' /opt/php/etc/php.ini
RUN sed -i '/^display_errors =/cdisplay_errors = On' /opt/php/etc/php.ini
RUN sed -i '/^display_startup_errors =/cdisplay_startup_errors = On' /opt/php/etc/php.ini
RUN echo '[opcache]' >> /opt/php/etc/php.ini
RUN echo 'zend_extension=opcache.so' >> /opt/php/etc/php.ini
RUN echo 'extension=redis.so' >> /opt/php/etc/php.ini

EXPOSE 9000
ENTRYPOINT /opt/php/sbin/php-fpm -R --nodaemonize
