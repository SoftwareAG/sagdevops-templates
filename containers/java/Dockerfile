FROM daerepository03.eur.ad.sag:4443/ibit/java:10.3

ENV SAG_HOME=/opt/softwareag

# Create sagadmin a process owner and group
# RUN groupadd -g 1724 sagadmin && \
#    useradd -u 1724 -m -g 1724 -d $SAG_HOME -c "SoftwareAG Admin" sagadmin
# ENV JAVA_HOME=$SAG_HOME/jvm/jvm/
# ENV JRE_HOME=$SAG_HOME/jvm/jvm/jre/
# ENV PATH=$PATH:$JAVA_HOME/bin

USER 1724

RUN env && java -version

WORKDIR $SAG_HOME

ENTRYPOINT java
