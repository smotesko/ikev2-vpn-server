FROM debian:jessie-slim

ENV HOST HOSTNAME

LABEL version="1.0.1" update="09-05-2017"

RUN AUTO_ADDED_PACKAGES=`apt-mark showauto` && apt-get update && DEBIAN_FRONTEND=noninteractive \
    && apt-get install -y -q --no-install-recommends \
    openssl strongswan uuid-runtime iptables \
    && apt-get remove --purge -y $AUTO_ADDED_PACKAGES \
    && rm -rf /var/cache/apt/* \
    && rm -f /etc/ipsec.secrets

ADD ./etc/* /etc/
ADD ./bin/* /usr/bin/

EXPOSE 500/udp 4500/udp

CMD /usr/bin/start-vpn

