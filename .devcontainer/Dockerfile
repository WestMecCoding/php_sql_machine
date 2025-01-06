# 1. Start with the dev container base (same as before)
FROM mcr.microsoft.com/devcontainers/base:ubuntu

# 2. Disable interactive prompts and update
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get -y install --no-install-recommends \
    vim \
    tmux \
    apache2 \
    libapache2-mod-php \
    php \
    php-cli \
    php-mysql \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 3. Copy your .vimrc and tmux.conf into the container
COPY .vimrc /home/vscode/.vimrc
COPY tmux.conf /home/vscode/.tmux.conf

# 4. Make sure /home/vscode is owned by the vscode user
RUN chown -R vscode:vscode /home/vscode

# 5. Enable any mods you need in Apache
RUN a2enmod rewrite \
 && a2enmod headers

# 6. (Optional) Copy your custom Apache config if you want 
#    the DocumentRoot set to /workspaces, etc.
# COPY apache-config.conf /etc/apache2/sites-available/000-default.conf

# 7. Expose port 80 for Apache
EXPOSE 80

# 8. Start Apache in the foreground
CMD ["apache2ctl", "-D", "FOREGROUND"]
