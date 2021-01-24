FROM mysql:8.0

ARG TIME_ZONE

RUN apt-get update && \
  apt-get install -y tzdata && \
  cp /usr/share/zoneinfo/$TIME_ZONE /etc/localtime
