
### 1. Get Linux
FROM ubuntu:18.04

ARG ROBOT=1.6.0
ARG DOSDP=0.14
ARG JENA=3.12.0
ARG BGR=1.6
ARG KBOT=1.11
ARG RELGRAPH=1.0

ENV LANG en_US.UTF-8

### 2. Get Java, Python and all required system libraries
RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y \
    software-properties-common \
    build-essential \
    openjdk-8-jdk \
    git \
    make \
    curl \
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
ENV VIRTUAL_ENV /tools/pyenv
ENV PATH "$VIRTUAL_ENV/bin:$PATH"

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
RUN curl -O -L https://github.com/INCATools/dosdp-tools/releases/download/v$DOSDP/dosdp-tools-$DOSDP.tgz \
    && tar -zxf dosdp-tools-$DOSDP.tgz \
    && chmod +x /tools/dosdp-tools-$DOSDP
ENV PATH "/tools/dosdp-tools-$DOSDP/bin:$PATH"

###### RELATION-GRAPH ######
RUN curl -O -L https://github.com/balhoff/relation-graph/releases/download/v$RELGRAPH/relation-graph-$RELGRAPH.tgz \
    && tar -zxf relation-graph-$RELGRAPH.tgz
ENV PATH "/tools/relation-graph-$RELGRAPH/bin:$PATH"

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
