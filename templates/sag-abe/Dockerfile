FROM daerepository03.eur.ad.sag:4443/ccdevops/commandcentral:10.2-builder as builder

FROM centos:7

ENV SAG_HOME=/opt/softwareag
ENV JAVA_HOME $SAG_HOME/jvm/jvm/
ENV JRE_HOME $SAG_HOME/jvm/jvm/jre/

COPY --from=builder $SAG_HOME/common/AssetBuildEnvironment/ $SAG_HOME/common/AssetBuildEnvironment/
COPY --from=builder $SAG_HOME/jvm/ $SAG_HOME/jvm/

CMD sagccant build
