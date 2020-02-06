#name of container: xowa
FROM debian:stable-slim
# thanks to Angel Rodriguez  "angel@quantumobject.com" for the inital dockerfile
MAINTAINER Scott Mundorff "scott.mundorff@gmail.com"

ENV XOWA_VERSION 4.6.5.1911

RUN mkdir -p /usr/share/man/man1
RUN apt-get update && apt-get install -y --no-install-recommends \
        openjdk-11-jre-headless \
        unzip \
        bzip2 \
        p7zip-full \
        wget \
 && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/xowa/wiki \
 && wget --no-check-certificate -O xowa.zip https://github.com/gnosygnu/xowa/releases/download/v$XOWA_VERSION/xowa_app_linux_64_v$XOWA_VERSION.zip \
 && unzip xowa.zip -d /opt/xowa \
 && rm -f xowa.zip

ENTRYPOINT ["java", "-Xmx256m", "-jar /opt/xowa/xowa_linux_64.jar", "--app_mode http_server"]

VOLUME /opt/xowa

EXPOSE 8080
