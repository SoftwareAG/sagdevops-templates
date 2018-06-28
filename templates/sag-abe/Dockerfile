ARG TAG=10.3
ARG BUILDER_IMAGE=daerepository03.eur.ad.sag:4443/ccdevops/commandcentral-builder:$TAG
ARG BASE_IMAGE=daerepository03.eur.ad.sag:4443/ibit/java:jdk-8-centos

FROM $BUILDER_IMAGE as builder

RUN $CC_HOME/provision.sh && ./test.sh && $CC_HOME/cleanup.sh

FROM $BASE_IMAGE

ENV ABE_HOME=$SAG_HOME/common/AssetBuildEnvironment
ENV CC_CLI_HOME=$SAG_HOME/CommandCentral/client
ENV PATH=$PATH:$ABE_HOME/bin:$CC_CLI_HOME/bin

# output folder
ENV BUILD_OUTPUT_DIR=/src/build/repo/
# build number for assets
ENV BUILD_NUMBER=1

COPY --from=builder $SAG_HOME/ $SAG_HOME/

WORKDIR /src

ENTRYPOINT [ "build.sh", "-Dbuild.source.dir=/src/", "-Dbuild.output.dir=${BUILD_OUTPUT_DIR}", "-Dbuild.number=${BUILD_NUMBER}" ]

