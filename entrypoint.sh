#!/bin/sh

cp -f /config/ipsec.conf /etc/ipsec.conf
cp -f /config/ipsec.secrets /etc/ipsec.secrets

sed -i 's/${POD_IP}/'"$POD_IP"'/g' /etc/ipsec.conf

[ -f "/config/local-private.pem" ]  && cp -f /config/local-private.pem /etc/ipsec.d/private/local-private.pem
[ -f "/config/local-public.pem" ] && cp -f /config/local-public.pem /etc/ipsec.d/certs/local-public.pem
[ -f "/config/remote-public.pem" ] && cp -f /config/remote-public.pem /etc/ipsec.d/certs/remote-public.pem

/usr/sbin/ipsec start --nofork
