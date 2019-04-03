FROM centos:7
MAINTAINER "ninjacn" <x@ninjacn.com>

RUN \
	yum -y update && \
	yum -y install epel-release yum-utils && \
	yum-config-manager --enable extras && \
	yum-config-manager --enable epel && \
	yum clean all && \
    (rm /var/cache/yum/x86_64/7/timedhosts 2>/dev/null || true) && \
	(rm /var/cache/yum/x86_64/7/timedhosts.txt 2>/dev/null || true)

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
        ImageMagick \
        ImageMagick-devel \
		vim \
		wget \
		which \
		whois \
		telnet \
		re2c \
        perl-Image-ExifTool \
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
