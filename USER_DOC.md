# USER_DOC.md

## 1) Services provided by the stack
This project provides 3 services:
- `nginx`: web server, exposes HTTP (`80`) and HTTPS (`443`), and redirects HTTP to HTTPS.
- `wordpress`: PHP-FPM container that runs WordPress.
- `mariadb`: database used by WordPress.

## 2) Start and stop the project
From the project root:

```bash
cd /home/lleodev/Documents/inception
```

Start:
```bash
make
```

Stop:
```bash
make clean
```

Stop and remove local persistent data:
```bash
make fclean
```

## 3) Access the website and admin panel
1. Ensure your domain is in `/etc/hosts`:
```bash
echo "127.0.0.1 lleodev.42.fr" | sudo tee -a /etc/hosts
```

2. Open the website:
- `https://lleodev.42.fr`

3. Open WordPress admin panel:
- `https://lleodev.42.fr/wp-admin`

## 4) Locate and manage credentials
Credentials are in two places:
- `.env` (WordPress and non-secret app settings)
- `srcs/secrets/` (database secrets)

Main files:
- `/home/lleodev/Documents/inception/.env`
- `/home/lleodev/Documents/inception/srcs/secrets/db_password.txt`
- `/home/lleodev/Documents/inception/srcs/secrets/db_root_password.txt`

Important values:
- WordPress admin user/password: `WP_ADMIN_USER`, `WP_ADMIN_PASSWORD` in `.env`
- DB user: `MYSQL_USER` in `.env`
- DB user password: `db_password.txt`
- DB root password: `db_root_password.txt`

After changing credentials, recreate the stack:
```bash
make clean
make
```

## 5) Check services health
Check running containers:
```bash
docker compose ps
```

Check logs:
```bash
docker compose logs --tail=100 nginx wordpress mariadb
```

Quick HTTP/HTTPS checks:
```bash
curl -I http://lleodev.42.fr
curl -kI https://lleodev.42.fr
```

Expected:
- HTTP returns `301` to HTTPS
- HTTPS returns `200` or `302`
