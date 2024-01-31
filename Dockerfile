ARG UBUNTU_VERSION=22.04
FROM ubuntu:${UBUNTU_VERSION}

ENV DEBIAN_FRONTEND=noninteractive

COPY install-openbts-from-source.sh /opt/install-openbts-from-source.sh
RUN chmod +x /opt/install-openbts-from-source.sh
RUN /opt/install-openbts-from-source.sh

COPY default-config.sh /opt/default-config.sh
RUN chmod +x /opt/default-config.sh
RUN /opt/default-config.sh

COPY init.sh /opt/init.sh

WORKDIR /OpenBTS
CMD /opt/init.sh
