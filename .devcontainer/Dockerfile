# Use the Microsoft base Dev Container image for Ubuntu
FROM mcr.microsoft.com/devcontainers/base:ubuntu

# Disable any interactive prompts during package install
ENV DEBIAN_FRONTEND=noninteractive

# -------------------------------------------------
# 1) Install OS Packages (including Apache, PHP)
# -------------------------------------------------
RUN apt-get update \
    && apt-get -y install --no-install-recommends \
    vim \
    tmux \
    apache2 \
    libapache2-mod-php \
    php \
    php-cli \
    php-curl \
    php-json \
    php-mbstring \
    php-zip \
    php-mysql \
    php-gd \
    curl \
    wget \
    unzip \
    nano \
    # Clean up
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# -------------------------------------------------
# 2) Copy Your Vim/Terminal Configs
# -------------------------------------------------
COPY .vimrc /home/vscode/.vimrc
COPY tmux.conf /home/vscode/.tmux.conf

# Set correct ownership for vscode user
RUN chown -R vscode:vscode /home/vscode

# Create .vim directory for plugins
RUN mkdir -p /home/vscode/.vim && chown -R vscode:vscode /home/vscode/.vim

# -------------------------------------------------
# 3) Install phpMyAdmin in /var/www/html/phpmyadmin
# -------------------------------------------------
RUN wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz -O /tmp/phpmyadmin.tar.gz \
    && mkdir /var/www/html/phpmyadmin \
    && tar xzf /tmp/phpmyadmin.tar.gz --strip-components=1 -C /var/www/html/phpmyadmin \
    && rm /tmp/phpmyadmin.tar.gz

# Enable Apache mod_rewrite (optional)
RUN a2enmod rewrite

# By default, expose port 80 for Apache
EXPOSE 80

# -------------------------------------------------
# 4) Start Apache in the Foreground by Default
# -------------------------------------------------
CMD ["apache2ctl", "-D", "FOREGROUND"]
