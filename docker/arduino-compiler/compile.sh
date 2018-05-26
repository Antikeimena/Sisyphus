#!/bin/bash

# For protobuf
git clone https://github.com/Antikeimena/Sisyphus.git

# Source code
git clone https://github.com/Antikeimena/Glaucus.git

mkdir -p /Glaucus/Main/lib/nanopb

cd /Sisyphus/protobuf
for name in config motor sensor status
do
    protoc --python_out=/host ${name}.proto
    protoc -o ${name}.pb      ${name}.proto
    python /nanopb/generator/nanopb_generator.py ${name}.pb
    mv ${name}.pb.c /Glaucus/Main/lib/nanopb/
    mv ${name}.pb.h /Glaucus/Main/lib/nanopb/
done

for name in pb.h pb_common.h pb_common.c pb_decode.h pb_decode.c pb_encode.h pb_encode.c
do
    cp /nanopb/${name}  /Glaucus/Main/lib/nanopb/
done

cd /Glaucus/Main/
platformio run

cp /Glaucus/Main/.pioenvs/megaatmega2560/firmware.hex /host/firmware.hex
