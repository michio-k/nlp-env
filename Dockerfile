FROM python:3.7

WORKDIR /workdir
COPY . .
RUN mkdir data \
    && mkdir notebooks \
    && mkdir script

RUN apt-get update -y && apt-get upgrade -y \
    && apt-get install --no-install-recommends -y git \
    && apt-get install -y mecab \
    && apt-get install -y libmecab-dev \
    && apt-get install -y mecab-ipadic \
    && apt-get install -y mecab-ipadic-utf8 \
    && apt-get install -y make \
    && apt-get install -y curl \
    && apt-get install -y xz-utils \
    && apt-get install -y file \
    && apt-get install -y sudo \
    && apt-get install -y vim \
    && apt-get -y clean

RUN git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git
WORKDIR /workdir/mecab-ipadic-neologd
RUN ./bin/install-mecab-ipadic-neologd -n -y
RUN ln -s /etc/mecabrc /usr/local/etc/mecabrc

WORKDIR /workdir
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

RUN jupyter serverextension enable --py jupyterlab
RUN jupyter notebook --generate-config
