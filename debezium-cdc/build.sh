#!/bin/bash

# please set cluster access crredentials in /yc-connect/connect-distributed.properties
# you may need specify sasl.jaas.config property to access your cluster

# instal jre
sudo apt install openjdk-11-jre-headless

#
# create trusted CA store and add YandexCA.crt as trusted root
wget "https://storage.yandexcloud.net/cloud-certs/CA.pem" -O ./yc-connect/YandexCA.crt
keytool -keystore ./yc-connect/client.truststore.jks -storepass 'pass@word1'  -alias CARoot -import -file ./yc-connect/YandexCA.crt

docker build -t yc/connect:1.6 -f ./yc-connect/Dockerfile yc-connect/.