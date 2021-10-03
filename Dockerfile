FROM python:3.8

ENV PYTHONUNBUFFERED=TRUE
ENV PYTHONDONTWRITEBYTECODE=TRUE
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update && apt-get install -y --no-install-recommends \
        curl \
        sudo \
        wget \
        g++ \
        make \
        cmake \
        vim \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash - \
    && sudo apt-get install -y nodejs

# Locale Japanese
ENV LC_ALL=ja_JP.UTF-8
# Timezone jst
RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

# jupyter lab
RUN pip3 install -U pip && \
    pip3 install jupyterlab && \
    pip3 install jupyterlab-git && \
    mkdir ~/.jupyter

COPY ./jupyter_notebook_config.py /root/.jupyter/jupyter_notebook_config.py

RUN jupyter serverextension enable --py jupyterlab && \
    jupyter labextension install --no-build jupyterlab-plotly && \
    jupyter lab build

COPY requirements.lock /tmp/requirements.lock
RUN python3 -m pip install -r /tmp/requirements.lock && \
    python3 -m ipykernel install --sys-prefix && \
    rm /tmp/requirements.lock && \
    rm -rf /root/.cache

# Set up the program in the image
COPY ml-pipelines /opt/ml-pipelines
WORKDIR /opt/ml-pipelines