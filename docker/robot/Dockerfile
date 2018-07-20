FROM ubuntu:18.10

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y autoconf automake libtool curl make g++ unzip mc git vim \
                       python python-pip 

# Protobuf
RUN git clone -b master --single-branch --depth 1 https://github.com/google/protobuf.git
WORKDIR protobuf
RUN ./autogen.sh
RUN ./configure
RUN make -j 9
#RUN make check
RUN make install
RUN ldconfig
WORKDIR python
ENV PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=cpp
ENV PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION_VERSION=2
RUN python setup.py build   --cpp_implementation 
RUN python setup.py test    --cpp_implementation
RUN python setup.py install --cpp_implementation

ADD protobuf/config.proto .
RUN protoc --python_out=/ config.proto
ADD protobuf/motor.proto .
RUN protoc --python_out=/ motor.proto
ADD protobuf/sensor.proto .
RUN protoc --python_out=/ sensor.proto
ADD protobuf/status.proto .
RUN protoc --python_out=/ status.proto




FROM python:latest

# Copy build artefacts
COPY --from=0 config_pb2.py /
COPY --from=0 motor_pb2.py  /
COPY --from=0 sensor_pb2.py /
COPY --from=0 status_pb2.py /

# Prepare python part
ADD python/* /
RUN pip install -r requirements.txt

CMD python -u Robot.py
