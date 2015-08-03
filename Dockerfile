FROM continuumio/miniconda

RUN apt-get -y install expat
RUN conda install -c ioos iris cartopy