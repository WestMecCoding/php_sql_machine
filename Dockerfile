# Dockerfile
FROM mcr.microsoft.com/devcontainers/php:0-8.2

# Keep the container running
CMD ["apache2-foreground"]

# .devcontainer/devcontainer.json
{
    "name": "PHP & MySQL Dev Environment",
    "dockerComposeFile": "docker-compose.yml",
    "service": "apache-php",
    "workspaceFolder": "/var/www/html",
    "forwardPorts": [8080, 8081, 3306],
    "remoteUser": "root"
}