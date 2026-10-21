FROM debian:trixie
ENV SSP_VER 2.3.7
RUN apt-get update && apt-get install -y \
        curl \
        libicu-dev \
        apache2 \
        libapache2-mod-php \
        php-xml  \
        composer \
        php-curl \
        php-intl \
        php-ldap \
        php-sqlite3 && \
     a2dissite 000-default && \
     a2enmod rewrite ssl
WORKDIR /var
RUN curl -L -o simplesamlphp.tar.gz https://github.com/simplesamlphp/simplesamlphp/releases/download/v$SSP_VER/simplesamlphp-$SSP_VER-full.tar.gz && \
        tar xvf simplesamlphp.tar.gz && \
        mv simplesamlphp-$SSP_VER simplesamlphp && \
        rm simplesamlphp.tar.gz && \
        cd simplesamlphp && \
        composer -W require simplesamlphp/simplesamlphp-module-entitycategories:v2.0.0 && \
        sed -i '$ i \\x27personalIdentityNumber\x27         => \x27urn:oid:1.2.752.29.4.13\x27,' /var/simplesamlphp/attributemap/name2oid.php && \
        ln -sfT /dev/stderr /var/log/apache2/error.log; \
	ln -sfT /dev/stdout /var/log/apache2/access.log; \
	ln -sfT /dev/stdout /var/log/apache2/other_vhosts_access.log


ADD modules/ /var/simplesamlphp/modules/
ADD start.sh /start.sh
ENTRYPOINT ["/start.sh"]
