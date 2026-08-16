FROM eclipse-temurin:21-jre-jammy

RUN apt-get update \
 && apt-get install -y --no-install-recommends curl ca-certificates \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /data

COPY scripts/start.sh /usr/local/bin/start
RUN chmod +x /usr/local/bin/start

EXPOSE 25565/tcp 25565/udp
VOLUME ["/data"]

ENTRYPOINT ["start"]
