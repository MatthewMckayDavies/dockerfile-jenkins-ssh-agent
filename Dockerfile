# https://www.jenkins.io/doc/book/installing/docker/
FROM jenkins/ssh-agent:jdk11
USER root

# Setup locale - https://hub.docker.com/_/ubuntu
RUN apt-get update && apt-get install -y locales \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

# Install docker CLI - https://docs.docker.com/engine/install/debian/
RUN apt-get install -y ca-certificates curl gnupg lsb-release
RUN mkdir -p /etc/apt/keyrings
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
RUN echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN apt-get update && apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Install docker compose - https://docs.docker.com/compose/install/
# docker compose is now part of the CLI

# Tidy apt
RUN rm -rf /var/lib/apt/lists/*

