# DEV_DOC.md

## 1) Environment setup from scratch
### Prerequisites
- Linux with Docker installed
- Docker Compose plugin (`docker compose`)
- `make`

### Project files to configure
- `.env`: runtime variables (domain, DB name/user, WordPress users)
- `srcs/secrets/db_password.txt`: password for `MYSQL_USER`
- `srcs/secrets/db_root_password.txt`: MariaDB root password

### Required host path setup
The project stores persistent data under:
- `/home/lleodev/data/mariadb`
- `/home/lleodev/data/wordpress`

The Makefile creates these paths automatically in `make all`.

### Hosts file
Map the domain from `.env` to localhost:
```bash
echo "127.0.0.1 lleodev.42.fr" | sudo tee -a /etc/hosts
```

## 2) Build and launch (Makefile + Docker Compose)
From project root:

```bash
cd /home/lleodev/Documents/inception
```

Main flow:
```bash
make
```
This runs:
- directory creation for data paths
- `docker compose up --build`

Alternative direct commands:
```bash
docker compose build
docker compose up -d
```

## 3) Useful management commands
### Containers
Start/restart detached:
```bash
docker compose up -d
```

Stop and remove containers/network:
```bash
docker compose down
```

Service status:
```bash
docker compose ps
```

Logs:
```bash
docker compose logs --tail=100
docker compose logs -f nginx
docker compose logs -f wordpress
docker compose logs -f mariadb
```

Rebuild one service:
```bash
docker compose up -d --build nginx
docker compose up -d --build wordpress
docker compose up -d --build mariadb
```

### Volumes/data cleanup
Project cleanup command:
```bash
make fclean
```

Manual Docker cleanup (if needed):
```bash
docker compose down -v
```

## 4) Data location and persistence model
Persistent data is configured in `docker-compose.yml` with named volumes using bind options.

### MariaDB data
- Container path: `/var/lib/mysql`
- Host path: `/home/lleodev/data/mariadb`

### WordPress data
- Container path: `/var/www/html`
- Host path: `/home/lleodev/data/wordpress`

Because these are bind-backed volumes, data remains on the host even if containers are recreated.
Data is removed only when you explicitly delete the host directories (for example via `make fclean`).
