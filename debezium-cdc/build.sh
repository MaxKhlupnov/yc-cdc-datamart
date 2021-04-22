#!/bin/bash

# please set cluster access crredentials in /yc-connect/connect-distributed.properties
# you may need specify sasl.jaas.config property to access your cluster

# instal jre
sudo apt install openjdk-11-jre-headless

#
# create trusted CA store and add YandexCA.crt as trusted root

wget "https://storage.yandexcloud.net/cloud-certs/CA.pem" -O ./yc-connect/1.6/YandexCA.crt

keytool -keystore ./yc-connect/1.6/client.truststore.jks -storepass 'pass@word1'  -alias CARoot -import -file ./yc-connect/1.6/YandexCA.crt

# create trusted CA store and add YandexCA.crt as trusted root
docker build -t debezium/kafka:1.6 -f ./kafka/Dockerfile kafka/1.6/.
docker build -t debezium/connect-base:1.6 -f ./connect-base/Dockerfile connect-base/1.6/.
docker build -t debezium/connect:1.6 -f ./connect/Dockerfile connect/1.6/.
docker build -t yc/connect:1.6 -f ./yc-connect/Dockerfile yc-connect/1.6/.

wget "https://storage.yandexcloud.net/cloud-certs/CA.pem" -O ./yc-connect/1.4/YandexCA.crt
keytool -keystore ./yc-connect/1.4/client.truststore.jks -storepass 'pass@word1'  -alias CARoot -import -file ./yc-connect/1.4/YandexCA.crt

docker build -t debezium/kafka:1.4 -f ./kafka/Dockerfile kafka/1.4/.
docker build -t debezium/connect-base:1.4 -f ./connect-base/Dockerfile connect-base/1.4/.
docker build -t debezium/connect:1.4 -f ./connect/Dockerfile connect/1.4/.
docker build -t yc/connect:1.4 -f ./yc-connect/Dockerfile yc-connect/1.4/.