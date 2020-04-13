
### 1. Get Linux
FROM ubuntu:18.04

ENV ROBOT 1.5.0
ARG ROBOT_JAR=https://github.com/ontodev/robot/releases/download/$ROBOT/robot.jar
ENV ROBOT_JAR ${ROBOT_JAR}
ENV DOSDPVERSION 0.13.1
ENV JENA 3.12.0
ENV BGR 1.4
ENV KBOT 1.9.1


### 2. Get Java and all required system libraries
RUN apt-get update && apt-get upgrade -y \
 && apt-get install -y software-properties-common build-essential git openjdk-8-jre openjdk-8-jdk

RUN apt-get install -y make curl wget tar


### 3. Install custom tools
WORKDIR /tools

# Avoid repeated downloads of script dependencies by mounting the local coursier cache:
docker run -v $HOME/.coursier/cache/v1:/tools/.coursier-cache ...
ENV COURSIER_CACHE "/tools/.coursier-cache"


###### JENA ######
RUN curl -O -L http://archive.apache.org/dist/jena/binaries/apache-jena-$JENA.tar.gz \
    && tar -zxf apache-jena-$JENA.tar.gz
ENV PATH "/tools/apache-jena-$JENA/bin:$PATH"


###### ROBOT ######
RUN curl -O -L https://github.com/ontodev/robot/releases/download/v$ROBOT/robot.jar \
    && curl -O -L https://github.com/ontodev/robot/raw/v$ROBOT/bin/robot \
    && chmod +x robot
ENV PATH "/tools:$PATH"


###### DOSDPTOOLS ######
RUN curl https://github.com/INCATools/dosdp-tools/releases/download/v$DOSDPVERSION/dosdp-tools-$DOSDPVERSION.tgz \
    && tar -zxvf dosdp-tools-$DOSDPVERSION.tgz \
    && mv dosdp-tools-$DOSDPVERSION /tools/dosdp-tools \
ENV PATH "/tools/dosdp-tools/bin:$PATH"

###### BLAZEGRPAH-RUNNER ######
RUN curl -O -L https://github.com/balhoff/blazegraph-runner/releases/download/v$BGR/blazegraph-runner-$BGR.tgz \
    && tar -zxf blazegraph-runner-$BGR.tgz
ENV PATH "/tools/blazegraph-runner-$BGR/bin:$PATH"

###### KB-OWL-TOOLS ######
RUN curl -O -L https://github.com/phenoscape/phenoscape-owl-tools/releases/download/v$KBOT/kb-owl-tools-$KBOT.tgz \
    && tar -zxf kb-owl-tools-$KBOT.tgz
ENV PATH "/tools/kb-owl-tools-$KBOT/bin:$PATH"

RUN chmod +x /tools/*

