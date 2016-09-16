FROM mhart/alpine-node:latest
MAINTAINER Kevin Swiber <kswiber@apigee.com>

COPY configure.sh /usr/bin/local/configure.sh

RUN npm install -g edgemicro@2.1.0-beta

CMD ["edgemicro", "start"]

EXPOSE 8000
