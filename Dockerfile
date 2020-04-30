FROM alpine:3.11

LABEL maintainer="Jiri Frantisek <jiri.frantisek@wandera.com>"

RUN apk --no-cache add strongswan \
    && sed -i 's/# install_routes = yes/install_routes = no/g' /etc/strongswan.d/charon.conf \
    && ln -sf /config/ipsec.conf /etc/ipsec.conf \
    && ln -sf /config/ipsec.secrets /etc/ipsec.secrets \
    && ln -sf /config/local-private.pem /etc/ipsec.d/private/local-private.pem \
    && ln -sf /config/local-public.pem /etc/ipsec.d/certs/local-public.pem \
    && ln -sf /config/remote-public.pem /etc/ipsec.d/certs/remote-public.pem

EXPOSE 500/udp 4500/udp

ENTRYPOINT ["/usr/sbin/ipsec"]

CMD ["start", "--nofork"]