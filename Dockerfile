# Stage 1: Build and prepare the application
FROM alpine:latest

WORKDIR /data

ENV MIN_MEM=""
ENV MAX_MEM=""
ENV EULA=""
ENV MOTD=""
ENV OPS=""

COPY entrypoint.sh /data/entrypoint.sh
COPY icon.png /data/icon.png
COPY spigot-1.20.1.jar /data/spigot-1.20.1.jar
COPY server.properties /data/server.properties
COPY eula.txt /data/eula.txt

RUN chmod +x /data/entrypoint.sh
RUN apk update && \
    apk add --no-cache openjdk17-jre curl jq screen

EXPOSE 25565

ENTRYPOINT ["/data/entrypoint.sh"]
