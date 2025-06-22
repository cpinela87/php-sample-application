# Imagen base con PHP 7.4 + Apache
FROM php:7.4-apache

# ── Paquetes y extensiones necesarios 
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git unzip libzip-dev && \
    docker-php-ext-install pdo pdo_mysql mysqli zip && \
    a2enmod rewrite && \
    rm -rf /var/lib/apt/lists/*

# cambia DocumentRoot en todos los vhosts
ENV APACHE_DOCUMENT_ROOT /var/www/html/web

RUN sed -ri "s!/var/www/html!${APACHE_DOCUMENT_ROOT}!g" \
        /etc/apache2/sites-available/*.conf \
        /etc/apache2/apache2.conf \
        /etc/apache2/conf-available/*.conf


RUN sed -ri "s#<Directory ${APACHE_DOCUMENT_ROOT}>#<Directory ${APACHE_DOCUMENT_ROOT}>\n\tAllowOverride All#g" \
    /etc/apache2/apache2.conf

# ── Ajusta include_path global ─────────────────────────────────────
RUN echo 'include_path=".:/usr/local/lib/php:/var/www/html"' \
      > /usr/local/etc/php/conf.d/90-include-path.ini
# ───────────────────────────────────────────────────────────────────

WORKDIR /var/www/html
COPY . .

# Enlace simbólico de config → config-dev
RUN ln -s /var/www/html/config-dev /var/www/html/config

# Instala Composer y dependencias
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && composer install --no-dev --optimize-autoloader

RUN composer dump-autoload --optimize

# Variables por defecto
ENV DB_HOST=db \
    DB_NAME=sample \
    DB_USER=sampleuser \
    DB_PASS=samplepass

EXPOSE 80
