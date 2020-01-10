FROM ibmcom/db2
 
ENV LICENSE=accept
ENV PERSISTENT_HOME=false
ENV DB2INST1_PASSWORD=manage
ENV AUTOCONFIG=false

# Every bash file in the "/var/custom" folder will be run after the db2 is started
RUN mkdir /var/custom 
COPY init_db2.sh /var/custom
# Create user "webm" with password "manage" that will be used later to access the database
RUN useradd -rm -d /home/webm -s /bin/bash -g root -u 1000 webm -p "$(openssl passwd -1 manage)"
RUN chmod a+x /var/custom/init_db2.sh
 
