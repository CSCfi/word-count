#version 0.1
FROM alpine:3.10

#maintainer information
LABEL maintainer="kthw@kth.se"

# update the apt package manager
RUN apk update
#RUN add-apt-repository ppa:deadsnakes/ppa  # python-3.6 here
#RUN apt-get update && apt-get -y install locales


# install make and nano
#RUN apt-get install -y build-essential && apt-get install -y nano

# install python
RUN apk add python3 #  python3.6-dev python3-pip python3.6-venv
RUN pip3 install --upgrade pip
RUN yes | pip3 install numpy  ## FIXME
RUN yes | pip3 install matplotlib
RUN yes | pip3 install snakemake

# unicode locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# create symlink from python3 to python
RUN ln -s $(which python3) /usr/bin/python

# copy project to container
COPY ./ /opt/word_count/

# set work directory in container
WORKDIR /opt/word_count

# default command to execute when container starts
CMD /bin/bash
