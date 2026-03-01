*This project has been created as part of the 42 curriculum by `lleodev`.*

## Description
Inception is a Docker infrastructure project where each service runs in its own container:
- `nginx` handles HTTP/HTTPS and reverse proxy;
- `wordpress` runs on PHP-FPM;
- `mariadb` stores application data.

The goal is to build a reproducible multi-service setup using custom Docker images and Docker Compose orchestration.

### Docker usage and sources included in the project
The project uses Docker to isolate services and control dependencies per container.

Source structure:
- `docker-compose.yml`: orchestrates services, networks, volumes and secrets.
- `srcs/nginx/`: Nginx Dockerfile, config template and startup script.
- `srcs/php-fpm/`: PHP-FPM/WordPress Dockerfile and bootstrap script.
- `srcs/mariadb/`: MariaDB Dockerfile, DB config and init script.
- `srcs/secrets/`: Docker secrets files.
- `.env`: runtime environment variables.

### Main design choices
- Strict service separation (`nginx`, `wordpress`, `mariadb`).
- Internal communication through Docker bridge network.
- Persistent data in bind-backed named volumes.
- Sensitive DB credentials delivered through Docker secrets.

### Comparison
#### Virtual Machines vs Docker
- Virtual Machines include a full guest OS and have higher overhead.
- Docker containers share the host kernel and are lighter/faster.
- Docker is better suited here for fast rebuilds and reproducible service orchestration.

#### Secrets vs Environment Variables
- Environment variables are simple but easier to expose accidentally.
- Docker secrets are mounted as files at runtime (`/run/secrets/*`).
- This project uses secrets for DB passwords.

#### Docker Network vs Host Network
- Bridge network provides isolation and internal DNS by service name.
- Host network removes that isolation and can increase port conflict risk.
- This project uses a dedicated bridge network (`inception`).

#### Docker Volumes vs Bind Mounts
- Docker volumes are abstract and Docker-managed.
- Bind mounts map explicit host paths, useful for direct inspection.
- This project uses named volumes with bind paths in `/home/lleodev/data/*`.

## Instructions
### Prerequisites
- Docker
- Docker Compose (`docker compose`)
- Make

### Host configuration
Add your domain (from `.env`) to `/etc/hosts`:

```bash
echo "127.0.0.1 lleodev.42.fr" | sudo tee -a /etc/hosts
```

### Setup
1. Edit `.env` values.
2. Set secret files:
- `srcs/secrets/db_password.txt`
- `srcs/secrets/db_root_password.txt`

### Build and run
```bash
make
```

### Stop
```bash
make clean
```

### Full cleanup
```bash
make fclean
```

### Quick checks
```bash
docker compose ps
curl -I http://lleodev.42.fr
curl -kI https://lleodev.42.fr
```

## Resources
### References
- Docker documentation: https://docs.docker.com/
- Docker Compose documentation: https://docs.docker.com/compose/
- Nginx documentation: https://nginx.org/en/docs/
- MariaDB documentation: https://mariadb.com/kb/en/documentation/
- WordPress documentation: https://developer.wordpress.org/
- WP-CLI documentation: https://wp-cli.org/

### AI usage
AI was used to:
- troubleshoot integration issues between Nginx, PHP-FPM and MariaDB;
- diagnose runtime errors (upstream resolution, FastCGI, HTTP/HTTPS behavior);
- improve and structure technical documentation.

Final implementation choices and runtime validation were performed directly in the project environment.
