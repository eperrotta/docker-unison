FROM phusion/baseimage:0.9.16
CMD ["/sbin/my_init"]

MAINTAINER Leigh McCulloch

# Upload Unison for building
COPY container /

# Build and install Unison versions then cleanup
RUN apt-get update -y \
 && curl -LO http://download.opensuse.org/repositories/home:ocaml/xUbuntu_14.04/Release.key \
 && apt-key add - < Release.key \
 && apt-get update -y \
 && unison-compile-each.sh \
 && rm -rf /var/lib/{apt,dpkg,cache,log}/ /tmp/* /var/tmp/*

# Set default Unison configuration
ENV UNISON_VERSION=2.48.3
ENV UNISON_WORKING_DIR=/unison
ENV OCAML_MINOR_VERSION=4.02

RUN unison-link.sh

# Set working directory to be the home directory
WORKDIR /root

# Setup unison to run as a service
VOLUME $UNISON_WORKING_DIR
EXPOSE 5000
