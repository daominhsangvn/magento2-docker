FROM ubuntu:20.04

WORKDIR /bin

RUN apt-get update && apt-get install -y wget

RUN wget -c https://github.com/jonnenauha/prometheus_varnish_exporter/releases/download/1.6/prometheus_varnish_exporter-1.6.linux-386.tar.gz -O - | tar -xz prometheus_varnish_exporter-1.6.linux-386/prometheus_varnish_exporter --strip-components 1

ENTRYPOINT ["./prometheus_varnish_exporter"]

# ENTRYPOINT ["./prometheus_varnish_exporter", "-docker-container-name", "varnish"]
