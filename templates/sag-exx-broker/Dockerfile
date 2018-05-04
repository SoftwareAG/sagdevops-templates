ARG BUILDER_IMAGE
ARG BASE_IMAGE

FROM $BUILDER_IMAGE as builder

RUN $CC_HOME/provision.sh

FROM $BASE_IMAGE

#RUN groupadd sag && useradd sag -g sag -d /opt/softwareag -s /bin/bash -M
#USER sag

ENV EXXDIR=$SAG_HOME/EntireX

# expose any ports from runtimes defined in the template.yaml
EXPOSE 1971

# entrypoint scripts
ADD entrypoint.sh $EXXDIR/bin/

ENTRYPOINT $EXXDIR/entrypoint.sh
