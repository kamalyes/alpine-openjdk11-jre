FROM alpine:3.16.2

USER root

RUN mkdir -p /deployments

COPY run-java.sh /deployments/

ENV JAVA_APP_DIR=/deployments \
  JAVA_OPTIONS="-Dfile.encoding=utf-8" \
  LOG4J_FORMAT_MSG_NO_LOOKUPS=true \
  JAVA_MAJOR_VERSION=11 \
  JAVA_MAX_HEAP_RATIO=40

RUN apk add --update --no-cache tzdata curl fontconfig ttf-dejavu openjdk11-jre nss \
  && cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone && apk del tzdata \
  && echo "securerandom.source=file:/dev/urandom" >> /usr/lib/jvm/default-jvm/jre/lib/security/java.security \
  && rm -rf /tmp/* /var/tmp/* /var/cache/apk/* \
  && chmod 755 /deployments/run-java.sh

CMD [ "/deployments/run-java.sh" ]
