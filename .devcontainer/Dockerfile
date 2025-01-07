# .devcontainer/Dockerfile

# Start from a lightweight Ubuntu LTS image
FROM ubuntu:22.04

# Avoid interactive prompts during build
ENV DEBIAN_FRONTEND=noninteractive

# 1) Install system packages
RUN apt-get update \
 && apt-get install -y \
    apache2 \
    php \
    libapache2-mod-php \
    php-mysql \
    git \
    curl \
    vim \
    tmux \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# 2) Copy custom Apache config (listen on port 80, docroot at /workspace, etc.)
COPY .devcontainer/apache-config.conf /etc/apache2/sites-available/000-default.conf

# Enable Apache rewrite (if needed)
RUN a2enmod rewrite

# 3) Create 'vscode' user (if it doesn’t exist) with sudo
RUN useradd -m vscode \
 && echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# 4) Switch to vscode user to install vim-plug
USER vscode
RUN mkdir -p /home/vscode/.vim/autoload \
 && curl -fLo /home/vscode/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# 5) Copy your .vimrc and .tmux.conf into /home/vscode
USER root
COPY .devcontainer/.vimrc /home/vscode/.vimrc
COPY .devcontainer/.tmux.conf /home/vscode/.tmux.conf
RUN chown vscode:vscode /home/vscode/.vimrc /home/vscode/.tmux.conf
RUN mkdir -p /workspace && chown vscode:vscode /workspace
# 6) Expose port 80 (mapped to 8080 in docker-compose.yml)
EXPOSE 80

# 7) Run Apache in foreground as container's main process
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
