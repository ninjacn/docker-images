FROM ninjacn/docker-centos7:latest
MAINTAINER "ninjacn" <x@ninjacn.com>

COPY ./files/php-7.2.34.tar.gz /tmp/
RUN cd /tmp && mkdir -p php_src \
    && tar -zxf php-7.2.34.tar.gz -C php_src --strip-components=1 \
    && rm php-7.2.34.tar.gz \
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
RUN /opt/php/bin/pecl install imagick

RUN ln -s /opt/php/bin/php /usr/bin/php \
    && cp /opt/php/etc/php-fpm.conf.default /opt/php/etc/php-fpm.conf \
    && cp /opt/php/etc/php-fpm.d/www.conf.default /opt/php/etc/php-fpm.d/www.conf \
    && cd /tmp/php_src \
    && cp php.ini-production /opt/php/etc/php.ini \
    && rm -rf /tmp/php_src

RUN curl -sS https://getcomposer.org/installer | /opt/php/bin/php && \
	mv composer.phar /usr/local/bin/composer && \
	composer self-update

# install zookeeper
COPY ./files/zookeeper-3.4.14.tar.gz /tmp/
RUN cd /tmp && mkdir -p zookeeper \
    && tar -zxf zookeeper-3.4.14.tar.gz -C zookeeper --strip-components=1 \
    && rm zookeeper-3.4.14.tar.gz \
    && ( \
        cd zookeeper/zookeeper-client/zookeeper-client-c \
        && ./configure \
        && make \
        && make install \
    )\
    && rm -r zookeeper
RUN /opt/php/bin/pecl install zookeeper
RUN echo 'extension=zookeeper.so' >> /opt/php/etc/php.ini

#install ssh2
#RUN yum -y update && \
RUN while true; do \
		if yum -y install \
		libssh2 \
		libssh2-devel \
		; then \
			break; \
		else \
			yum clean all && \
			(rm /var/cache/yum/x86_64/7/timedhosts 2>/dev/null || true) && \
			(rm /var/cache/yum/x86_64/7/timedhosts.txt 2>/dev/null || true) && \
			yum -y update; \
		fi \
	done \
	\
	&& \
	\
	yum clean all && \
	(rm /var/cache/yum/x86_64/7/timedhosts 2>/dev/null || true) && \
	(rm /var/cache/yum/x86_64/7/timedhosts.txt 2>/dev/null || true)

#COPY ./files/libssh2-1.9.0.tar.gz /tmp/
#RUN cd /tmp && mkdir -p libssh2 \
    #&& tar -zxf libssh2-1.9.0.tar.gz -C libssh2 --strip-components=1 \
    #&& rm libssh2-1.9.0.tar.gz \
    #&& ( \
        #cd libssh2 \
        #&& mkdir bin \
        #&& cd bin \
        #&& cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local/libssh2 \
        #&& make install \
    #)\
    #&& rm -r libssh2
# pecl ssh2
COPY ./files/ssh2-1.3.1.tgz /tmp/
RUN cd /tmp && mkdir -p ssh2 \
    && tar -zxf ssh2-1.3.1.tgz -C ssh2 --strip-components=1 \
    && rm ssh2-1.3.1.tgz \
    && ( \
        cd ssh2 \
        && /opt/php/bin/phpize \
        && ./configure --with-php-config=/opt/php/bin/php-config \
        && make \
        && make install \
    )\
    && rm -r ssh2
# end ssh2

RUN sed -i '/^listen = /clisten = 127.0.0.1:9000' /opt/php/etc/php-fpm.d/www.conf
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
RUN echo 'extension=imagick.so' >> /opt/php/etc/php.ini
RUN echo 'extension=ssh2.so' >> /opt/php/etc/php.ini

#debug
#RUN php -i \
    #&& exit 1

EXPOSE 9000
ENTRYPOINT /opt/php/sbin/php-fpm -R --nodaemonize
