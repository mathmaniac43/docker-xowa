#name of container: xowa
FROM openjdk:8-alpine
# thanks to Angel Rodriguez  "angel@quantumobject.com" for the inital dockerfile
MAINTAINER Scott Mundorff "scott.mundorff@gmail.com"

ENV XOWA_VERSION 4.6.15.2101

RUN apk add --no-cache --virtual .build-deps wget unzip \
 && mkdir -p /opt/xowa/wiki \
 && wget --no-verbose --no-check-certificate -O xowa.zip https://github.com/gnosygnu/xowa/releases/download/v$XOWA_VERSION/xowa_app_linux_64_v$XOWA_VERSION.zip \
 && unzip -q xowa.zip -d /opt/xowa \
 && rm -f xowa.zip \
 && apk del .build-deps

ENTRYPOINT ["java", "-Xmx256m", "-jar", "/opt/xowa/xowa_linux_64.jar"]
CMD ["--app_mode", "http_server"]

VOLUME /opt/xowa

EXPOSE 8080
