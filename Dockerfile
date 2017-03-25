FROM openjdk:8u121-jre
maintainer cjjavellana@gmail.com

USER root

ENV VERSION 5.2.2

RUN wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-$VERSION.tar.gz -O /elasticsearch-$VERSION.tar.gz && \
tar xzvf /elasticsearch-$VERSION.tar.gz && \
mv /elasticsearch-$VERSION /elasticsearch 

EXPOSE 9200 9300

COPY run.sh /run.sh
COPY config /elasticsearch/config

RUN mkdir -p /data/data && \
mkdir -p /data/log && \
chmod -R ugo+rwx /data && \
chmod -R ugo+rwx  /elasticsearch && \
chmod ugo+x /run.sh

# Set environment variables defaults
ENV ES_JAVA_OPTS "-Xms512m -Xmx512m"
ENV CLUSTER_NAME elasticsearch
ENV NODE_MASTER true
ENV NODE_DATA true
ENV NODE_INGEST true
ENV HTTP_ENABLE true
ENV NETWORK_HOST _site_
ENV HTTP_CORS_ENABLE true
ENV HTTP_CORS_ALLOW_ORIGIN *
ENV NUMBER_OF_MASTERS 1
ENV NUMBER_OF_SHARDS 1
ENV NUMBER_OF_REPLICAS 0
ENV MAX_LOCAL_STORAGE_NODES 1
ENV DISCOVERY_SERVICE elasticsearch-discovery

CMD ["/run.sh"]

