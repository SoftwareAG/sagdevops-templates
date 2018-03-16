FROM daerepository03.eur.ad.sag:4443/ccdevops/commandcentral:10.2-internal as builder

FROM daerepository03.eur.ad.sag:4443/ibit/java:jdk-8-centos

# ENV SAG_HOME=/opt/softwareag
# ENV JAVA_HOME $SAG_HOME/jvm/jvm/
# ENV JRE_HOME $SAG_HOME/jvm/jvm/jre/

ENV PATH=$PATH:$SAG_HOME/common/AssetBuildEnvironment/bin:$SAG_HOME/CommandCentral/client/bin

COPY --from=builder $SAG_HOME/common/AssetBuildEnvironment/ $SAG_HOME/common/AssetBuildEnvironment/
COPY --from=builder $SAG_HOME/CommandCentral/client/ $SAG_HOME/CommandCentral/client/

# COPY --from=builder $SAG_HOME/jvm/ $SAG_HOME/jvm/

# raw ABE
# CMD build.sh
