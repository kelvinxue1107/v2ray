FROM ubuntu:latest as builder

RUN apt-get update
RUN apt-get install curl -y 
RUN apt-get install netcat -y
RUN apt-get install wget -y
RUN curl -L -o /tmp/go.sh https://install.direct/go.sh
RUN chmod +x /tmp/go.sh
RUN /tmp/go.sh
#install acme.sh for ssl connections.
RUN curl https://get.acme.sh | sh
EXPOSE 80
RUN ~/.acme.sh/acme.sh --issue -d geforce.io --standalone -k ec-256

FROM alpine:latest

LABEL maintainer "kelvin.xue@outlook.com"

COPY --from=builder /usr/bin/v2ray/v2ray /usr/bin/v2ray/
COPY --from=builder /usr/bin/v2ray/v2ctl /usr/bin/v2ray/
COPY --from=builder /usr/bin/v2ray/geoip.dat /usr/bin/v2ray/
COPY --from=builder /usr/bin/v2ray/geosite.dat /usr/bin/v2ray/
COPY v2rayconfig-tls.json /etc/v2ray/config.json
RUN  ~/.acme.sh/acme.sh --installcert -d geforce.io --fullchainpath /etc/v2ray/v2ray.crt --keypath /etc/v2ray/v2ray.key --ecc

RUN set -ex && \
    apk --no-cache add ca-certificates && \
    mkdir /var/log/v2ray/ &&\
    chmod +x /usr/bin/v2ray/v2ctl && \
    chmod +x /usr/bin/v2ray/v2ray
EXPOSE 443

ENV PATH /usr/bin/v2ray:$PATH

CMD ["v2ray", "-config=/etc/v2ray/config.json"]