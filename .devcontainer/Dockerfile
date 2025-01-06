FROM mcr.microsoft.com/devcontainers/base:ubuntu

# Install required packages
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    vim \
    tmux \
    && rm -rf /var/lib/apt/lists/*

# Copy configuration files
COPY .vimrc /home/vscode/.vimrc
COPY tmux.conf /home/vscode/.tmux.conf

# Set correct ownership
RUN chown -R vscode:vscode /home/vscode/

# Create .vim directory for plugins
RUN mkdir -p /home/vscode/.vim && chown -R vscode:vscode /home/vscode/.vim