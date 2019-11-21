FROM centos:7
USER root
#RUN yum -y update; yum clean all
RUN yum -y install openssh-server passwd; yum clean all
RUN mkdir /var/run/sshd
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''
EXPOSE 22
RUN useradd sagadmin \
   && SSH_USERPASS=sagadmin \
   && echo -e "$SSH_USERPASS\n$SSH_USERPASS" | (passwd --stdin sagadmin) \
   && echo credentials are sagadmin:sagadmin \
   && mkdir -p /opt/softwareag \
   && chown -R sagadmin /opt/softwareag

ENTRYPOINT ["/usr/sbin/sshd", "-D"]
