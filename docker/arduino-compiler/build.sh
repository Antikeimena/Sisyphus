#!/bin/bash

# make library folder for platformio
mkdir -p /host/Glaucus/Main/lib/nanopb

# Build protobuf files for python and c
cd /host/Sisyphus/protobuf
for name in config motor sensor status
do
    protoc --python_out=/host/Sisyphus/python/   ${name}.proto
    protoc -o ${name}.pb                         ${name}.proto
    python /nanopb/generator/nanopb_generator.py ${name}.pb
    mv ${name}.pb.c /host/Glaucus/Main/lib/nanopb/
    mv ${name}.pb.h /host/Glaucus/Main/lib/nanopb/
done

# Copy protoful main lib files as well
for name in pb.h pb_common.h pb_common.c pb_decode.h pb_decode.c pb_encode.h pb_encode.c
do
    cp /nanopb/${name}  /host/Glaucus/Main/lib/nanopb/
done

cd /host/Glaucus/Main/
platformio upgrade
platformio update
platformio lib update
platformio run

cp /host/Glaucus/Main/.pioenvs/megaatmega2560/firmware.hex /host/Glaucus/firmware.hex
