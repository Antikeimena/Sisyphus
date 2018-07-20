#!/usr/bin/env bash

AVRDUDE_CONFIG_FILE=${HOME}/git/Sisyphus/conf/avrdude.conf
HEX_URL=https://s3.amazonaws.com/ansi-antikeimena/firmware.hex
HEX_FILE=${HOME}/firmware.hex

# get firmware
rm -f ${HEX_FILE}
curl -o ${HEX_FILE} ${HEX_URL}

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
