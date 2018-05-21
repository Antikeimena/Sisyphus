#!/usr/bin/env bash

mkdir ../../arduino/lib/nanopb

for name in config motor sensor status
do
    protoc --proto_path ../../protobuf/ --python_out=../python ../../protobuf/${name}.proto
    protoc --proto_path ../../protobuf/ -o ${name}.pb          ../../protobuf/${name}.proto
    python /nanopb/generator/nanopb_generator.py ${name}.pb
    rm ${name}.pb
    mv ${name}.pb.c ../../arduino/lib/nanopb/
    mv ${name}.pb.h ../../arduino/lib/nanopb/
done

cp /nanopb/pb.h        ../../arduino/lib/nanopb/
cp /nanopb/pb_common.h ../../arduino/lib/nanopb/
cp /nanopb/pb_common.c ../../arduino/lib/nanopb/
cp /nanopb/pb_decode.h ../../arduino/lib/nanopb/
cp /nanopb/pb_decode.c ../../arduino/lib/nanopb/
cp /nanopb/pb_encode.h ../../arduino/lib/nanopb/
cp /nanopb/pb_encode.c ../../arduino/lib/nanopb/

cd  ./../../arduino/
#platformio init
#platformio lib install id=883 #Servo
platformio run

cp .pioenvs/megaatmega2560/firmware.hex firmware/sisyphus.hex