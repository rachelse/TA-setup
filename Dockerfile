################################################################################
# File: Dockerfile                                                             #
# Project: introbioinfo-exercise06-setup                                       #
# Created: 2023-05-21                                                          #
# Author: Seongeun Kim (eunbelivable@snu.ac.kr)                                #
# Description:                                                                 #
#     This code is written as part of project "introbioinfo-exercise06-setup". #
# ---                                                                          #
# Last Modified: 2023-05-25                                                    #
# Modified By: Seongeun Kim (eunbelivable@snu.ac.kr)                           #
# ---                                                                          #
# Copyright © 2023 Seongeun Kim, All rights reserved                           #
################################################################################

FROM --platform=linux/amd64 ubuntu:20.04
USER root
ARG EXERCISE_NAME=exercise06
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

# Run and configurate conda environment
RUN /bin/bash -c "source activate && \
	conda config --add channels defaults && \
	conda config --add channels conda-forge && \
	conda config --add channels bioconda "

# Install bioinformatics tools
RUN	conda install -n base -y conda-libmamba-solver
RUN	conda install -n base -y --solver=libmamba \
                    samtools hisat2 stringtie
RUN pip install pydeseq2
RUN conda install -c conda-forge gcc=12.1.0



# create a user
RUN useradd --create-home --shell /bin/bash $EXERCISE_NAME
USER $EXERCISE_NAME
WORKDIR /home/$EXERCISE_NAME
# Make RUN commands use `bash --login`:
SHELL ["/bin/bash", "--login", "-c"]