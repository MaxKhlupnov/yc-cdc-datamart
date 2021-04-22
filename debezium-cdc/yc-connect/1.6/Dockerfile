FROM debezium/connect:1.6

LABEL maintainer="Yandex Cloud Architects Community"

#
# Build  certificate store
#
COPY --chown=kafka:kafka YandexCA.crt $KAFKA_HOME/config/YandexCA.crt
COPY --chown=kafka:kafka client.truststore.jks $KAFKA_HOME/config/client.truststore.jks
#RUN keytool -keystore $KAFKA_HOME/config/client.truststore.jks -storepass 'pass@word1' -noprompt  -alias CARoot -import -file $KAFKA_HOME/config/YandexCA.crt
#
# Copy key store into kafka/config
#
COPY --chown=kafka:kafka connect-distributed.properties $KAFKA_HOME/config/connect-distributed.properties
