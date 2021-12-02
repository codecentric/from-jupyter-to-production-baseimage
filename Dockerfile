FROM python:3.7

ENV SHELL /bin/bash

ADD configs/jupyter_notebook_config.py /root/.jupyter/jupyter_notebook_config.py
WORKDIR /workshop

RUN apt-get -qq update && apt-get -qq -y install curl bzip2 \
    && curl -sSL https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -o /tmp/miniconda.sh \
    && bash /tmp/miniconda.sh -bfp /usr/local \
    && rm -rf /tmp/miniconda.sh \
    && conda install -y python=3.7 \
    && conda update conda \
    && apt-get -qq -y remove bzip2 \
    && apt-get -qq -y autoremove \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* /var/log/dpkg.log
ENV PATH /opt/conda/bin:$PATH

RUN apt-get update && apt-get install -y libgl1-mesa-glx

COPY environment.yml .
RUN conda env create -f environment.yml 
RUN conda clean --all --yes && conda init bash 

# dirty hack to patch ipython to work with apple silicon/m1 processors
RUN find / -name "eventloops.py" -print0 | xargs -0 sed -i -e "s/V('10.9')/V('10.9') and platform.mac_ver()[2] != 'arm64'/"

EXPOSE 8888 4141 5000
CMD ["conda", "run", "-n", "workshop", "jupyter", "lab"]
