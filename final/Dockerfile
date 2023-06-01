################################################################################
# File: Dockerfile                                                             #
# Project: introbioinfo-final-setup                                            #
# Created: 2023-06-01                                                          #
# Author: Seongeun Kim (eunbelivable@snu.ac.kr)                                #
# Description:                                                                 #
#     This code is written as part of project "introbioinfo-final-setup".      #
# ---                                                                          #
# Last Modified: 2023-06-01                                                    #
# Modified By: Seongeun Kim (eunbelivable@snu.ac.kr)                           #
# ---                                                                          #
# Copyright © 2023 Seongeun Kim, All rights reserved                           #
################################################################################

FROM --platform=linux/amd64 ubuntu:20.04
USER root
ARG EXERCISE_NAME=final
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH

# Install dependencies
RUN apt-get update --fix-missing && \
	apt-get install -y build-essential wget gzip tar zip bzip2 curl git file vim nano iputils-ping  && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

# Install miniconda3
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
	/bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    /opt/conda/bin/conda clean --all -y && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
	echo "conda activate && cd" >> ~/.bashrc

# Install python
RUN	conda install -c anaconda python=3.10