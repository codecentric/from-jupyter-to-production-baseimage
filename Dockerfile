FROM python:3.6

ENV SHELL /bin/bash

ADD configs/jupyter_notebook_config.py /root/.jupyter/jupyter_notebook_config.py
WORKDIR /workshop

RUN apt-get -qq update && apt-get -qq -y install curl bzip2 \
    && curl -sSL https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -o /tmp/miniconda.sh \
    && bash /tmp/miniconda.sh -bfp /usr/local \
    && rm -rf /tmp/miniconda.sh \
    && conda install -y python=3.6 \
    && conda update conda \
    && apt-get -qq -y remove curl bzip2 \
    && apt-get -qq -y autoremove \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* /var/log/dpkg.log \
    && conda clean --all --yes
ENV PATH /opt/conda/bin:$PATH

RUN apt-get update
RUN apt-get install -y libgl1-mesa-glx

COPY environment.yml .
RUN conda env create -f environment.yml

ADD fruits fruits

EXPOSE 8888
CMD ["conda", "run", "-n", "dvc-tutorial", "jupyter", "lab"]