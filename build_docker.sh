#!/bin/bash

VERSION=1.7-6
DOCKERHUB_REPO="jeremykuhnash/haproxy-pass"

rm -f appgoto.pem key.pem
openssl req -subj '/CN=appgoto' -nodes -x509 -newkey rsa:4096 -keyout key.pem -out appgoto.pem
HTTP_IMAGE=$(docker build . -f Dockerfile.http | grep built | cut -f 3 -d " ")
SSL_IMAGE=$(docker build . -f Dockerfile.ssl | grep built | cut -f 3 -d " ")

HTTP_IMAGE_UP=$DOCKERHUB_REPO:http-$VERSION
SSL_IMAGE_UP=$DOCKERHUB_REPO:ssl-$VERSION

docker tag $HTTP_IMAGE $HTTP_IMAGE_UP
docker tag $SSL_IMAGE $SSL_IMAGE_UP

docker push $HTTP_IMAGE_UP
docker push $SSL_IMAGE_UP