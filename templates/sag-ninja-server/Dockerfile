ARG BUILDER_IMAGE
ARG BASE_IMAGE

FROM $BUILDER_IMAGE as builder

ARG NINJA_MEM_MAX=300

RUN $CC_HOME/provision.sh

FROM $BASE_IMAGE

EXPOSE 4444 4445 4446 4447

# copy everything as is from the builder stage
COPY --from=builder $SAG_HOME/ $SAG_HOME/

# basic entry point
ADD entrypoint.sh $SAG_HOME/
ENTRYPOINT $SAG_HOME/entrypoint.sh
