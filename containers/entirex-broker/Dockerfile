###############################################################################
#  Copyright © 2013 - 2018 Software AG, Darmstadt, Germany and/or its licensors
#
#   SPDX-License-Identifier: Apache-2.0
#
#     Licensed under the Apache License, Version 2.0 (the "License");
#     you may not use this file except in compliance with the License.
#     You may obtain a copy of the License at
#
#        http://www.apache.org/licenses/LICENSE-2.0
#
#     Unless required by applicable law or agreed to in writing, software
#     distributed under the License is distributed on an "AS IS" BASIS,
#     WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#     See the License for the specific language governing permissions and
#     limitations under the License.                                                            
#
###############################################################################

ARG BUILDER_IMAGE
ARG BASE_IMAGE

FROM $BUILDER_IMAGE as builder

ARG TEMPLATE=sag-exx-broker

RUN $CC_HOME/provision.sh $TEMPLATE

FROM $BASE_IMAGE

# setting environment variables, can be overwritten during startup
ENV EXX_LICENSE_KEY=license.xml
ENV EXX_ATTRIBUTE=etbfile
ENV EXX_KEY_FILE=ExxAppKey.pem
ENV EXX_KEY_STORE=ExxAppCert.pem
ENV EXX_TRUST_STORE=ExxCACert.pem

# setting internal environment variables
ENV SAG_HOME=/opt/softwareag
ENV EXXDIR=/opt/softwareag/EntireX
ENV ETBID=ETB001
ENV TCPPORT=1971
ENV SSLPORT=1958


COPY --from=builder --chown=1724:1724 $SAG_HOME/common/security/ $SAG_HOME/common/security/
COPY --from=builder --chown=1724:1724 $SAG_HOME/common/saglic/ $SAG_HOME/common/saglic/
COPY --from=builder --chown=1724:1724 $EXXDIR/lib/ $EXXDIR/lib/
COPY --from=builder --chown=1724:1724 $EXXDIR/bin/etbnuc $EXXDIR/bin/etbnuc
COPY --from=builder --chown=1724:1724 $EXXDIR/bin/etbcmd $EXXDIR/bin/etbcmd
COPY --from=builder --chown=1724:1724 $EXXDIR/config/etb/ETB001/ $EXXDIR/config/etb/ETB001/

USER root
RUN chown -R 1724:1724 $EXXDIR/config

COPY --chown=1724:1724 healthcheck.sh $EXXDIR/bin
COPY --chown=1724:1724 entrypoint.sh $EXXDIR/bin

EXPOSE $TCPPORT
EXPOSE $SSLPORT

WORKDIR $SAG_HOME

USER sagadmin

HEALTHCHECK --interval=5s --timeout=15s CMD sh $EXXDIR/bin/healthcheck.sh || exit 1

ENTRYPOINT $EXXDIR/bin/entrypoint.sh
