# LICENSE UPL 1.0
#
# Copyright (c) 2014, 2019, Oracle and/or its affiliates. All rights reserved.
#
# ORACLE DOCKERFILES PROJECT
# --------------------------
#
# Dockerfile template for Oracle Instant Client
#
# HOW TO BUILD THIS IMAGE
# -----------------------
#
# Run:
#      $ docker build -t oracle/instantclient:19 .
#
# Note Instant Client 19 automatically configures the global library
# search path to include Instant Client libraries.
#
# FROM oraclelinux:7-slim
FROM fnproject/node:dev as build-stage
WORKDIR /function
ADD package.json /function/
RUN npm install
RUN npm install request

FROM fnproject/node
WORKDIR /function
ADD . /function/
COPY --from=build-stage /function/node_modules/ /function/node_modules/
ENTRYPOINT ["node", "func.js"]