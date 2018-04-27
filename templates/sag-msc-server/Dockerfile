# Use stock, default or custom builder image
ARG BUILDER_IMAGE
# Use any base image
ARG BASE_IMAGE

ARG IS_INSTANCE_NAME=msc

FROM $BUILDER_IMAGE as builder
RUN $CC_HOME/provision.sh

FROM $BASE_IMAGE

ENV SAG_HOME=/opt/softwareag
ENV JAVA_HOME=$SAG_HOME/jvm/jvm/
ENV JRE_HOME=$SAG_HOME/jvm/jvm/jre/

ENV IS_INSTANCE_NAME=${IS_INSTANCE_NAME}

EXPOSE 5555 9999 8094 8092 8093

# copy everything from the builder stage $SAG_HOME
COPY --from=builder $SAG_HOME/ $SAG_HOME/

# custom entry point
ADD entrypoint.sh $SAG_HOME/
ENTRYPOINT $SAG_HOME/entrypoint.sh
