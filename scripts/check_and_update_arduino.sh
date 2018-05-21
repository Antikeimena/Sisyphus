#!/usr/bin/env bash

SOURCE_LOCATION=${HOME}/antikeimena
HEX_FILE=${SOURCE_LOCATION}/arduino/firmware/sisyphus.hex
AVRDUDE_CONFIG_FILE=${SOURCE_LOCATION}/sisyphus/conf/avrdude.conf

# update
cd ${SOURCE_LOCATION}
git pull

# check communication
sudo avrdude -C ${AVRDUDE_CONFIG_FILE} -v -p m2560 -c raspi
rc=$?
if [[ ${rc} != 0 ]]
 then
  echo "Error talking to the arduino"
  exit
fi

# flash new version
sudo avrdude -C ${AVRDUDE_CONFIG_FILE} -v -p m2560 -c raspi -U flash:w:${HEX_FILE}:i
rc=$?
if [[ ${rc} != 0 ]]
 then
  echo "Error flashing firmware to the arduino"
  exit
fi

