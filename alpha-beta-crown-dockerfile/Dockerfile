
FROM nvidia/cuda:11.2.2-base-ubuntu20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y wget git openssh-client bc sudo psmisc

RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh
RUN bash ~/miniconda.sh -b -p $HOME/miniconda

ENV GIT_SSL_NO_VERIFY=true

RUN git config --global core.eol lf && \
    git config --global core.autocrlf false

ENV PATH="/root/miniconda/bin:${PATH}"

WORKDIR /usr/src/app

RUN git clone https://github.com/Verified-Intelligence/alpha-beta-CROWN.git

WORKDIR /usr/src/app/alpha-beta-CROWN

RUN git submodule init && \
    git config submodule.auto_LiRPA.url https://github.com/Verified-Intelligence/auto_LiRPA.git && \
    git submodule update

WORKDIR /usr/src/app

RUN conda clean --all

RUN /bin/bash -c ". activate && conda env create -f alpha-beta-CROWN/complete_verifier/environment.yaml --name alpha-beta-crown"

RUN pip install /usr/src/app/alpha-beta-CROWN/auto_LiRPA

RUN mkdir "vnncomp2023_benchmarks"
WORKDIR /usr/src/app/vnncomp2023_benchmarks

RUN git init && \
    git remote add origin https://github.com/ChristopherBrix/vnncomp2023_benchmarks.git && \
    git config core.sparseCheckout true && \
    echo 'benchmarks/acasxu/*' >> .git/info/sparse-checkout && \
    echo 'run_all_categories.sh' >> .git/info/sparse-checkout && \
    echo 'run_single_instance.sh' >> .git/info/sparse-checkout && \
    git pull origin main && \
    find . -type f -name "*.gz" -exec gunzip {} \;

WORKDIR /usr/src/app

RUN find /usr/src/app/alpha-beta-CROWN -type f -name "*.sh" -exec chmod +x {} \;

RUN pip3 install numpy

WORKDIR /usr/src/app/alpha-beta-CROWN/complete_verifier

CMD ["/bin/bash", "-c", ". activate alpha-beta-crown && python /usr/src/app/alpha-beta-CROWN/complete_verifier/abcrown.py --config /usr/src/app/alpha-beta-CROWN/complete_verifier/exp_configs/vnncomp23/acasxu.yaml.txt"]
