FROM openjdk:11.0.8-slim

MAINTAINER rong <rongmazhong@gmail.com>

ENV JAVA_HOME=/usr/java/default/ \
    ZK_HOSTS=localhost:2181 \
    KM_CONFIGFILE="application.conf"
RUN apt-get update
RUN apt-get install -y wget unzip && \
    mkdir -p /tmp && \
    cd /tmp && \
    wget https://github.com/yahoo/CMAK/releases/download/3.0.0.5/cmak-3.0.0.5.zip && \
    unzip  -d / ./cmak-3.0.0.5.zip && \
    mv /cmak-3.0.0.5 /kafka-manager && \
    rm -fr /tmp/* && \
    apt-get autoremove -y wget unzip && \
    apt-get clean all

ADD application.conf /kafka-manager/application.conf
ADD start-kafka-manager.sh /kafka-manager/start-kafka-manager.sh

RUN chmod +x /kafka-manager/start-kafka-manager.sh 

WORKDIR /kafka-manager

EXPOSE 9000
ENTRYPOINT ["./start-kafka-manager.sh"]
