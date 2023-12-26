FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive


RUN apt-get update && apt-get install -y software-properties-common

RUN add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y python3.8 python3.8-venv python3.8-dev


RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 1 && \
    update-alternatives --set python3 /usr/bin/python3.8

RUN apt-get install -y python3-pip && \
    python3 -m pip install --upgrade pip


RUN apt-get install -y --no-install-recommends \
    sudo \
    curl \
    wget \
    git \
    build-essential \
    bc \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

ENV GIT_SSL_NO_VERIFY=true

RUN mkdir "vnncomp2023"

WORKDIR /usr/src/app/vnncomp2023

RUN git init && \
    git remote add origin https://github.com/ChristopherBrix/vnncomp2023_benchmarks.git && \
    git config core.sparseCheckout true && \
    echo 'benchmarks/acasxu/*' > .git/info/sparse-checkout && \
    echo 'run_all_categories.sh' >> .git/info/sparse-checkout && \
    echo 'run_single_instance.sh' >> .git/info/sparse-checkout && \
    git pull origin main

RUN find . -type f -name "*.gz" -exec echo {} \; -exec gunzip {} \;

WORKDIR /usr/src/app
RUN git clone https://github.com/Verified-Intelligence/alpha-beta-CROWN.git
RUN git clone --branch vnn-comp-23 https://github.com/wu-haoze/Marabou.git

RUN pip3 install numpy

WORKDIR /usr/src/app/vnncomp2023/benchmarks/acasxu
RUN python3 generate.py

RUN chmod +x /usr/src/app/vnncomp2023/run_all_categories.sh && \
    chmod +x /usr/src/app/vnncomp2023/run_single_instance.sh

WORKDIR /usr/src/app
