# .devcontainer/Dockerfile
FROM mcr.microsoft.com/devcontainers/base:ubuntu

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
        apache2 \
        php \
        libapache2-mod-php \
        php-mysql \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

RUN a2enmod rewrite
RUN a2enmod headers

COPY apache-config.conf /etc/apache2/sites-available/000-default.conf

EXPOSE 80
