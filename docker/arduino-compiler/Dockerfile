FROM ubuntu:latest

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y autoconf automake libtool curl make g++ unzip mc git vim \
                       python python-pip 

# Protobuf
RUN git clone -b master --single-branch --depth 1 https://github.com/google/protobuf.git
WORKDIR protobuf
RUN ./autogen.sh
RUN ./configure
RUN make
#RUN make check
RUN make install
RUN ldconfig
WORKDIR python
ENV PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=cpp
ENV PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION_VERSION=2
RUN python setup.py build   --cpp_implementation 
RUN python setup.py test    --cpp_implementation
RUN python setup.py install --cpp_implementation


# NanoProtobuf
WORKDIR /
RUN git clone -b master --single-branch --depth 1 https://github.com/nanopb/nanopb.git
WORKDIR /nanopb/generator/proto
RUN make

# Arduino
WORKDIR /
RUN pip install -U platformio

WORKDIR /
