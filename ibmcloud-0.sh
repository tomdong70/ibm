#!/bin/sh

	ramsize=256


	appname=redruddy0913

cd tomdong

wget -N https://raw.githubusercontent.com/tomdong70/ibm/master/ws.sh

rm -rf $HOME/tomdong/ws.zip
wget -N https://raw.githubusercontent.com/tomdong70/ibm/master/config.json
zip ws.zip config.json
rm -rf $HOME/tomdong/config.json

rm -rf manifest.yml
echo 'applications:'>>manifest.yml
echo '- path: .'>>manifest.yml
#echo '  command: '/app/htdocs/ws.sh'' >>manifest.yml
echo '  name: '$appname''>>manifest.yml
echo '  random-route: true'>>manifest.yml
echo '  memory: '$ramsize'M'>>manifest.yml

ibmcloud target --cf
ibmcloud cf push

domain=`ibmcloud cf app $appname | grep routes | cut -f2 -d':' | sed 's/ //g'`
cd ..
echo OK
