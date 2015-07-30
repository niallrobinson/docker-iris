FROM ubuntu:14.04

RUN apt-get update
RUN apt-get install -y python-pip

RUN apt-get update && apt-get install -y wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1
RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda-3.9.1-Linux-x86_64.sh && \
    /bin/bash /Miniconda-3.9.1-Linux-x86_64.sh -b -p /opt/conda && \
    rm Miniconda-3.9.1-Linux-x86_64.sh && \
    /opt/conda/bin/conda install --yes conda==3.14.0

ENV PATH /opt/conda/bin:$PATH

RUN wget http://download.osgeo.org/proj/proj-4.8.0.tar.gz
RUN wget http://download.osgeo.org/proj/proj-datumgrid-1.5.tar.gz

RUN tar xzf proj-4.8.0.tar.gz
RUN tar xzf proj-datumgrid-1.5.tar.gz

RUN proj-4.8.0/configure
RUN make
RUN sudo make install

RUN echo /usr/local/lib >> /etc/ld.so.conf
RUN ldconfig

RUN pip install pyshp

RUN conda install -c scitools cartopy
RUN conda install -c scitools iris
