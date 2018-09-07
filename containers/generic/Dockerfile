ARG BUILDER_IMAGE
FROM $BUILDER_IMAGE as builder

ARG TEMPLATE=sag-spm-config
RUN $CC_HOME/provision.sh $TEMPLATE && $CC_HOME/cleanup.sh

ARG BASE_IMAGE
FROM $BASE_IMAGE as base

ARG PORT=8092
ARG ENTRYPOINT=profiles/SPM/bin/console.sh
ENV ENTRYPOINT $ENTRYPOINT
EXPOSE $PORT

COPY --from=builder --chown=1724:1724 /opt/softwareag/ /opt/softwareag/

ENTRYPOINT [ "sh", "-c", "$ENTRYPOINT" ]
