FROM alpine:3.11

LABEL maintainer="Jiri Frantisek <jiri.frantisek@wandera.com>"

RUN apk --no-cache add strongswan \
    && sed -i 's/# install_routes = yes/install_routes = no/g' /etc/strongswan.d/charon.conf 

EXPOSE 500/udp 4500/udp

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
