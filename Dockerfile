FROM alpine:3.7

RUN apk add --update ca-certificates git openssl py-pip

RUN pip install --upgrade pip && pip install s3cmd

RUN wget -O - https://raw.githubusercontent.com/kubernetes/helm/v2.9.1/scripts/get | sh
