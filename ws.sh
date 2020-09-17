#! /bin/bash

#wget -N https://raw.githubusercontent.com/tomdong70/ibm/master/config.json

unzip -q ws.zip
chmod 777 *
ws -config config.json
