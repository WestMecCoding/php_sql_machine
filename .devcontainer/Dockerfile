# Start from a lightweight Ubuntu image
FROM ubuntu:22.04

# Avoid interactive prompts during build
ENV DEBIAN_FRONTEND=noninteractive

# Install packages
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

# Copy custom Apache config
COPY apache-config.conf /etc/apache2/sites-available/000-default.conf
RUN a2enmod rewrite

# Create a vscode user (if needed) and set up sudo
RUN useradd -m vscode \
    && echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Install vim-plug (for the 'vscode' user)
USER vscode
RUN mkdir -p /home/vscode/.vim/autoload
RUN curl -fLo /home/vscode/.vim/autoload/plug.vim --create-dirs \
     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Copy in .vimrc and .tmux.conf to the vscode home directory
USER root
COPY .vimrc /home/vscode/.vimrc
COPY .tmux.conf /home/vscode/.tmux.conf
RUN chown vscode:vscode /home/vscode/.vimrc /home/vscode/.tmux.conf

# Now switch to vscode user to run PlugInstall
USER vscode
# Non-interactive plug install
RUN vim -E -s -u /home/vscode/.vimrc \
      -c "try | PlugInstall --sync | catch | cquit | endtry" \
      -c "qa"

# Switch back to root to allow Docker to run Apache as root by default
USER root

# Expose port 80
EXPOSE 80

# Run apache in the foreground
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
