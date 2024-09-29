FROM alpine:latest

WORKDIR /keys

RUN apk add openssl
RUN mkdir temp
RUN openssl genrsa -passout "pass:${PASSPHRASE}" -des3 -out /keys/temp/private.pem 2048
RUN openssl rsa -in /keys/temp/private.pem -outform PEM -pubout -out public.pem -passin "pass:${PASSPHRASE}"
RUN openssl pkcs8 -in ./temp/private.pem -topk8 -nocrypt -out ./private.pem -passin "pass:${PASSPHRASE}"
RUN rm -r ./temp
