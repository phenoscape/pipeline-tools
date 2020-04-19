
### 1. Get Linux
FROM ubuntu:18.04

ENV ROBOT 1.5.0
ARG ROBOT_JAR=https://github.com/ontodev/robot/releases/download/$ROBOT/robot.jar
ENV ROBOT_JAR ${ROBOT_JAR}
ENV DOSDPVERSION 0.13.1
ENV JENA 3.12.0
ENV BGR 1.4
ENV KBOT 1.9.1


### 2. Get Java, Python and all required system libraries
RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y \
    software-properties-common \
    build-essential \
    openjdk-8-jdk \
    git \
    make \
    curl \
    wget \
    tar \
    python2.7 \
    python2.7-dev \
    python-pip


### 3. Install custom tools
WORKDIR /tools


### Python packages ###
RUN pip2 install virtualenv &&\
    virtualenv -p python2.7 pyenv &&\
    . pyenv/bin/activate &&\
    pip2 install 'pandas==0.19.1' &&\
    pip2 install 'scipy==0.15.1' &&\
    pip2 install 'patsy==0.4.1' &&\
    pip2 install 'statsmodels==0.6.1'


###### JENA ######
RUN curl -O -L http://archive.apache.org/dist/jena/binaries/apache-jena-$JENA.tar.gz \
    && tar -zxf apache-jena-$JENA.tar.gz
ENV PATH "/tools/apache-jena-$JENA/bin:$PATH"


###### ROBOT ######
RUN curl -O -L https://github.com/ontodev/robot/releases/download/v$ROBOT/robot.jar \
    && curl -O -L https://github.com/ontodev/robot/raw/v$ROBOT/bin/robot \
    && chmod +x robot
ENV PATH "/tools:$PATH"


###### DOSDP-TOOLS ######
RUN curl -O -L https://github.com/INCATools/dosdp-tools/releases/download/v$DOSDPVERSION/dosdp-tools-$DOSDPVERSION.tgz \
    && tar -zxf dosdp-tools-$DOSDPVERSION.tgz \
    && chmod +x /tools/dosdp-tools-$DOSDPVERSION
ENV PATH "/tools/dosdp-tools-$DOSDPVERSION/bin:$PATH"

###### BLAZEGRAPH-RUNNER ######
RUN curl -O -L https://github.com/balhoff/blazegraph-runner/releases/download/v$BGR/blazegraph-runner-$BGR.tgz \
    && tar -zxf blazegraph-runner-$BGR.tgz \
    && chmod +x /tools/blazegraph-runner-$BGR
ENV PATH "/tools/blazegraph-runner-$BGR/bin:$PATH"

###### KB-OWL-TOOLS ######
RUN curl -O -L https://github.com/phenoscape/phenoscape-owl-tools/releases/download/v$KBOT/kb-owl-tools-$KBOT.tgz \
    && tar -zxf kb-owl-tools-$KBOT.tgz \
    && chmod +x /tools/kb-owl-tools-$KBOT \
    && curl -L -O https://github.com/phenoscape/phenoscape-owl-tools/raw/v$KBOT/src/regression.py
ENV PATH "/tools/kb-owl-tools-$KBOT/bin:$PATH"
