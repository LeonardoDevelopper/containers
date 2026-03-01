FROM debian:bookworm

RUN apt-get update && apt-get install -y \
    php8.2-fpm php8.2-mysql mariadb-client curl ca-certificates \
    msmtp msmtp-mta mailutils \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL \
    https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    -o /usr/local/bin/wp \
    && chmod +x /usr/local/bin/wp 

COPY tools/run.sh usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

CMD [ "usr/local/bin/run.sh" ]