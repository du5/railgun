FROM debian:stretch-slim

ENV token=value \
    level=0 \
    ip=value

RUN apt-get update \
    && apt-get install curl gnupg2 -y \
    && curl -C - https://pkg.cloudflare.com/pubkey.gpg |  apt-key add - \
    && apt-key del 8e5f9a5d \
    && echo 'deb http://pkg.cloudflare.com/ stretch main' | tee /etc/apt/sources.list.d/cloudflare-main.list \
    && apt-get update \
    && apt-get install railgun-stable -y \
    && ln -sf /dev/stdout /var/log/syslog \
    && apt-get purge curl gnupg2 -y \
    && apt-get autoremove -y  \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 2408

CMD sed -i "s|YOUR_PUBLIC_IP_OR_HOSTNAME|${ip}|" /etc/railgun/railgun.conf \
    && sed -i "s|YOUR_TOKEN_HERE|${token}|" /etc/railgun/railgun.conf \
    && sed -i "s|log.level = 0|log.level = ${level}|" /etc/railgun/railgun.conf \
    && sed -i "s|/var/log/railgun/panic.log|/dev/stdout|" /etc/railgun/railgun.conf \
    && sed -i "s|memcached.servers = 127.0.0.1:11211|memcached.servers = memcached:11211|" /etc/railgun/railgun.conf \
    && /usr/bin/rg-listener -config=/etc/railgun/railgun.conf
