#!/bin/bash
RELEASE=7.9.1
docker run --name elastic-charts-certs -i -w /app \
  harbor-k8s.iwgame.com/containers/elasticsearch:$RELEASE \
  /bin/sh -c " \
    elasticsearch-certutil ca --out /app/elastic-stack-ca.p12 --pass '' && \
    elasticsearch-certutil cert --name security-master --dns security-master --ca /app/elastic-stack-ca.p12 --pass '' --ca-pass '' --out /app/elastic-certificates.p12" && \
docker cp elastic-charts-certs:/app/elastic-certificates.p12 ./ && \
docker rm -f elastic-charts-certs && \
openssl pkcs12 -nodes -passin pass:'' -in elastic-certificates.p12 -out elastic-certificate.pem
