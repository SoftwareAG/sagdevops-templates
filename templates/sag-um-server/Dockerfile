# MUST start with builder image to run provisioning using template.yaml
FROM daerepository03.eur.ad.sag:4443/ccdevops/commandcentral:10.2-internal as builder

ARG RELEASE=10.2
ARG VERSION=10.2.0.0
ARG REPO_PRODUCTS_URL=http://daeaquarius01.eur.ad.sag/dataserveSuiteInt/repository
ARG REPO_PRODUCTS_USERNAME=latest
ARG REPO_PRODUCTS_PASSWORD=latest
ARG REPO_FIXES_URL=http://aquarius-va.ame.ad.sag/updates/GA_Fix_Repo
ARG REPO_FIXES_USERNAME=sum
ARG REPO_FIXES_PASSWORD=sum
ARG LICENSES_URL=http://irepo.eur.ad.sag/projects/DEVOPS/repos/command-central/raw/licenses/sag10-rnd-all-licenses.zip?at=refs%2Fheads%2Frelease%2F101oct2017

RUN rm -f /root/.sag/cc.properties

WORKDIR /usr/share/sagcc/builder
ADD . .
RUN antcc builderBuild -Denv.properties=build.properties

# ADOPTED from docker file created by UM install
FROM daerepository03.eur.ad.sag:4443/ccdevops/commandcentral:10.2-node

# ENV SAG_HOME /opt/softwareag
ENV UM_HOME $SAG_HOME/UniversalMessaging
ENV UM_PORT 9000
# ENV JAVA_HOME $SAG_HOME/jvm/jvm
# ENV JRE_HOME $SAG_HOME/jvm/jvm/jre

# this should match the um instance that was specified in the CCE template
ENV INSTANCE default
ENV REALM default					

# Copy the minimum contents from the installation necessary to run a fully-functional realm server and the client tools
# COPY --from=builder $JAVA_HOME $JAVA_HOME
COPY --from=builder $UM_HOME/server/ $UM_HOME/server/
COPY --from=builder $UM_HOME/lib/ $UM_HOME/lib/

#### these are not there when build with CCE template...probably should add the NUM client too in the CCE template
#COPY --from=builder $SAG_HOME/UniversalMessaging/classes/ $SAG_HOME/UniversalMessaging/classes/
#COPY --from=builder $SAG_HOME/UniversalMessaging/java/ $SAG_HOME/UniversalMessaging/java/
#COPY --from=builder $SAG_HOME/UniversalMessaging/javascript/lib/ $SAG_HOME/UniversalMessaging/javascript/lib/

# Copy in the entrypoint script to facilitate launching the realm server
COPY *.sh $UM_HOME/

# Current working directory for all commands. This is where the UM installation is copied to within the image.
WORKDIR $UM_HOME

# Path gives access to 'umctx' and 'java', classpath gives access to all UM libraries
ENV PATH=/bin:/usr/bin:$UM_HOME/:$JAVA_HOME/bin/\
    CLASSPATH=lib/*

# Redirect plugin logs to the same place as the realm logs (i.e. stdout, to be captured by Docker's logging system)
# This is included for the benefit of having complete logging via Docker, but you may prefer to remove this line if you want the plugin logs
# segregated in separate files, rather than interleaved with the main realm server log
#RUN cd /um_home/server/umserver/; mkdir -p plugins/log/; cd plugins/log/; rm -f *; ln -s /dev/stdout error.log; ln -s /dev/stdout plugin.log; ln -s /dev/stdout access.log

# Remove state from the the installation to give you a 'clean slate' w.r.t licensing, keys, configuration and state
RUN rm -f `find $UM_HOME/ -name *.jks`; rm -rf $UM_HOME/server/license/;rm -rf $UM_HOME/server/$INSTANCE/data/

# Default realm name, can be customised by changing this line, or overriding this variable when running the image for the first time. After
# the image has been run once it is too late to change the realm name in subsequent derived images, as it gets baked into persistent
# configuration.

# Extra properties to pass to the realm server, intended for settings that can only be configured at realm server startup. The default here
# is to ask it to start it without using low-latency mode (CORE_SPIN), but this environment variable can be overridden when running the image.
ENV SERVER_OPTS_EXTRA -DCORE_SPIN=false

LABEL com.softwareag.product="UniversalMessaging" \com.softwareag.product.version="$VERSION" \com.softwareag.webmethodscloud.primaryPort="$UM_PORT"

# Expose the NSP/NHP port that the realm server starts an interface for by default
EXPOSE $UM_PORT

# The default operation for the image is to start a realm server
CMD ["entrypoint.sh"]
