FROM ninjacn/centos7:latest
MAINTAINER "ninjacn" <x@ninjacn.com>
#docker build -t registry.cn-beijing.aliyuncs.com/yaopengming/php-fpm-5.6:latest .

RUN \
	yum -y update && \
	yum -y install epel-release yum-utils && \
	yum-config-manager --enable extras && \
	yum-config-manager --enable epel && \
	yum clean all && \
    (rm /var/cache/yum/x86_64/6/timedhosts 2>/dev/null || true) && \
	(rm /var/cache/yum/x86_64/6/timedhosts.txt 2>/dev/null || true)

RUN yum -y update && \
	while true; do \
		if yum -y install \
		autoconf \
		automake \
		bash-completion \
		bind-utils \
		bzip2 \
		coreutils \
		dos2unix \
		file \
		git \
		git-svn \
		hostname \
		htop \
        gifsicle \
		iputils \
		moreutils \
		rubygems \
		sudo \
		vi \
		xz \
		gcc \
		gcc-c++ \
        perl-devel \
        gd-devel \
        libpng-devel \
        libjpeg-devel \
        libmcrypt-devel \
        libtool-ltdl \
        libtool-ltdl-devel \
        libxml2 \
        libxml2-devel \
        libcurl \
        libcurl-devel \
        bzip2 bzip2-devel \
        icu \
        openssl \
        openssl-devel \
        libtool-ltdl \
        libtool-ltdl-devel \
        libicu-devel \
		vim \
		wget \
		which \
		whois \
		; then \
			break; \
		else \
			yum clean all && \
			(rm /var/cache/yum/x86_64/6/timedhosts 2>/dev/null || true) && \
			(rm /var/cache/yum/x86_64/6/timedhosts.txt 2>/dev/null || true) && \
			yum -y update; \
		fi \
	done \
	\
	&& \
	\
	yum clean all && \
	(rm /var/cache/yum/x86_64/6/timedhosts 2>/dev/null || true) && \
	(rm /var/cache/yum/x86_64/6/timedhosts.txt 2>/dev/null || true)

#RUN curl -fsSL 'https://www.sno.phy.queensu.ca/~phil/exiftool/Image-ExifTool-11.32.tar.gz' \
     #-o Image-ExifTool-11.32.tar.gz \
    #&& mkdir -p image-exiftool \
    #&& tar -zxf Image-ExifTool-11.32.tar.gz -C image-exiftool --strip-components=1 \
    #&& rm Image-ExifTool-11.32.tar.gz \
    #&& ( \
        #cd image-exiftool \
        #&& perl Makefile.PL \
        #&& make \
        #&& make install \
    #)\
    #&& rm -r image-exiftool

COPY ./files/ImageMagick-6.9.12-8.tar.xz /tmp/
RUN cd /tmp && mkdir -p imagemagick \
    && tar -xf ImageMagick-6.9.12-8.tar.xz -C imagemagick --strip-components=1 \
    && rm ImageMagick-6.9.12-8.tar.xz \
    && ( \
        cd imagemagick \
        && ./configure \
        && make \
        && make install \
    )\
    && rm -r imagemagick

COPY ./files/php-5.6.40.tar.gz /tmp/
RUN cd /tmp && mkdir -p php56 \
    && tar -zxf php-5.6.40.tar.gz -C php56 --strip-components=1 \
    && rm php-5.6.40.tar.gz \
    && ( \
        cd php56 \
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
        --with-mysql=mysqlnd \
        --with-mysqli=mysqlnd \
        --enable-opcache \
        --with-pdo-mysql=mysqlnd \
        --enable-soap \
        --enable-sockets \
        --enable-zip \
        --enable-mysqlnd \
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

RUN ln -s /opt/php/bin/php /usr/bin/php \
    && cp /opt/php/etc/php-fpm.conf.default /opt/php/etc/php-fpm.conf \
    && cd /tmp/php56 \
    && cp php.ini-production /opt/php/etc/php.ini \
    && rm -rf /tmp/php56

#RUN curl -sS https://getcomposer.org/installer | /opt/php/bin/php && \
	#mv composer.phar /usr/local/bin/composer && \
	#composer self-update

RUN yum install telnet re2c -y
COPY ./files/imagick-3.1.2.tgz /tmp/
RUN cd /tmp && mkdir -p imagick \
    && tar -zxf imagick-3.1.2.tgz -C imagick --strip-components=1 \
    && rm imagick-3.1.2.tgz \
    && ( \
        cd imagick \
        && /opt/php/bin/phpize \
        && ./configure --with-php-config=/opt/php/bin/php-config \
        && make \
        && make install \
        && echo 'extension=imagick.so' >> /opt/php/etc/php.ini \
    )\
    && rm -r imagick

#RUN /opt/php/bin/pecl install redis
COPY ./files/redis-3.1.6.tgz /tmp/
RUN cd /tmp && mkdir -p redis \
    && tar -zxf redis-3.1.6.tgz -C redis --strip-components=1 \
    && rm redis-3.1.6.tgz \
    && ( \
        cd redis \
        && /opt/php/bin/phpize \
        && ./configure --with-php-config=/opt/php/bin/php-config \
        && make \
        && make install \
        && echo 'extension=redis.so' >> /opt/php/etc/php.ini \
    )\
    && rm -r redis

# php-fpm.conf
RUN sed -i '/^listen = /clisten = 127.0.0.1:9000' /opt/php/etc/php-fpm.conf
RUN sed -i '/^listen.allowed_clients/c;listen.allowed_clients =' /opt/php/etc/php-fpm.conf
RUN sed -i '/^user =/cuser = root' /opt/php/etc/php-fpm.conf
RUN sed -i '/^group =/cgroup = root' /opt/php/etc/php-fpm.conf
RUN sed -i '/^pm.max_children/cpm.max_children = 16' /opt/php/etc/php-fpm.conf
RUN sed -i '/^;error_log =/cerror_log = /tmp/php-fpm.log' /opt/php/etc/php-fpm.conf

# php.ini
RUN sed -i '/^;date.timezone =/cdate.timezone = Asia/Shanghai' /opt/php/etc/php.ini
RUN sed -i '/^display_errors =/cdisplay_errors = On' /opt/php/etc/php.ini
RUN sed -i '/^display_startup_errors =/cdisplay_startup_errors = On' /opt/php/etc/php.ini
RUN echo '[opcache]' >> /opt/php/etc/php.ini
RUN echo 'zend_extension=opcache.so' >> /opt/php/etc/php.ini

STOPSIGNAL SIGQUIT

EXPOSE 9000
#CMD ["/opt/php/sbin/php-fpm", "-R"]
ENTRYPOINT /opt/php/sbin/php-fpm -R --nodaemonize
