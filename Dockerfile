FROM golang:1.17.8-alpine3.15 AS builder

RUN apk --no-cache add git
RUN git clone --depth 1 --branch v0.4.0 https://github.com/dennisstritzke/ipsec_exporter.git \
    /go/src/github.com/dennisstritzke/ipsec_exporter

ENV PKG_NAME=github.com/dennisstritzke/ipsec_exporter
ENV PKG_PATH=$GOPATH/src/$PKG_NAME
WORKDIR $PKG_PATH

ENV CGO_ENABLED=0
RUN go build \
    --ldflags '-extldflags "-static"' \
    -o build/ipsec_exporter \
    github.com/dennisstritzke/ipsec_exporter
    
FROM alpine:3.15.1

LABEL maintainer="Jiri Frantisek <jiri.frantisek@wandera.com>"

RUN apk --no-cache add strongswan tcpdump iputils \
    && sed -i 's/# install_routes = yes/install_routes = no/g' /etc/strongswan.d/charon.conf 

COPY --from=builder /go/src/github.com/dennisstritzke/ipsec_exporter/build/ipsec_exporter /ipsec_exporter

COPY config/strongswan-override.conf /etc/strongswan.d/

EXPOSE 500/udp 4500/udp

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
