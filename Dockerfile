###
#
##

FROM ubuntu:latest

###
# Prepare
RUN apt-get update
RUN apt-get install -y openssh-server pwgen supervisor

RUN rm -rf /var/cache/apt && rm -rf /tmp/*
##

###
# Setup SSH
RUN mkdir /var/run/sshd

# Root Login
RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
RUN mkdir /root/.ssh
RUN chmod o-rwx /root/.ssh

ADD etc/sshd.conf /etc/supervisor/conf.d/sshd.conf

EXPOSE 22
##

###
# Scripts
ADD bin/* /opt/
RUN chmod +x /opt/*

CMD ["/opt/command"]
ENTRYPOINT /opt/entrypoint bash
##
