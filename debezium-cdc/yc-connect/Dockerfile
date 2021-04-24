FROM debezium/connect:1.6

LABEL maintainer="Yandex Cloud Architects Community"

#
# Build  certificate store
#
COPY --chown=kafka:kafka YandexCA.crt $KAFKA_HOME/config/YandexCA.crt
COPY --chown=kafka:kafka client.truststore.jks $KAFKA_HOME/config/client.truststore.jks
COPY --chown=kafka:kafka connect-distributed.properties $KAFKA_HOME/config/connect-distributed.properties