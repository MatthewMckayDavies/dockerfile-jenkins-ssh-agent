# https://www.jenkins.io/doc/book/installing/docker/
# https://github.com/jenkinsci/docker-ssh-agent
FROM jenkins/ssh-agent:debian-jdk17

# Setup locale - https://hub.docker.com/_/ubuntu
RUN apt-get update && apt-get install -y locales \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

# Install docker CLI - https://docs.docker.com/engine/install/debian/
RUN apt-get install -y ca-certificates curl gnupg
RUN install -m 0755 -d /etc/apt/keyrings
RUN curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
RUN chmod a+r /etc/apt/keyrings/docker.asc
RUN echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN apt-get update && apt-get install -y docker-ce-cli docker-compose-plugin

# Install docker compose - https://docs.docker.com/compose/install/
# docker compose is now part of the CLI

# Tidy apt
RUN rm -rf /var/lib/apt/lists/*

