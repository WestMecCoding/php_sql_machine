# Start from a lightweight Ubuntu image
FROM ubuntu:22.04

# Configure apt and install dependencies
RUN apt-get update \
 && apt-get install -y \
    apache2 \
    php \
    libapache2-mod-php \
    php-mysql \
    vim \
    tmux \
    git \
    curl \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Copy custom Apache config that listens on port 80 (will be mapped to 8080)
COPY apache-config.conf /etc/apache2/sites-available/000-default.conf

# Enable Apache mods (optional if you need rewrites, etc.)
RUN a2enmod rewrite

# Copy your .vimrc and .tmux.conf into /home/vscode (the default user in Codespaces)
# The container has a user named "vscode", so let's put them in that home directory
RUN mkdir -p /home/vscode
COPY .vimrc /home/vscode/.vimrc
COPY .tmux.conf /home/vscode/.tmux.conf
RUN chown vscode:vscode /home/vscode/.vimrc /home/vscode/.tmux.conf

# Expose port 80 inside the container
EXPOSE 80

# Create a new "vscode" user if it doesn't exist, give sudo privileges
RUN useradd -m vscode \
 && echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# By default, run Apache in the foreground
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
