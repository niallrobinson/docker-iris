FROM continuumio/miniconda

RUN apt-get update
RUN apt-get install expat
RUN conda install -c ioos iris cartopy