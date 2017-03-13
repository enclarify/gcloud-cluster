FROM debian:stretch

RUN apt-get update -y && \
  apt-get install -y \
    ca-certificates \
    curl \
    --no-install-recommends

ENV DOCKER_VERSION 1.11.2
RUN curl -sSL https://get.docker.com/builds/Linux/x86_64/docker-${DOCKER_VERSION}.tgz > /tmp/docker-latest.tgz && \
  tar -xf /tmp/docker-latest.tgz -C /tmp && \
  cp -R /tmp/docker/* /usr/bin && \
  rm -rf /tmp/docker*

ENTRYPOINT ["/bin/bash"]