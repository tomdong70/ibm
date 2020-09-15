#!/bin/sh
	appname=redruddy0913

	ramsize=256

cd $HOME/tomdong/v1
chmod 777 *
cd ..

rm -rf tomdong
mkdir tomdong
cd tomdong

echo '<!DOCTYPE html> '>>index.php
echo '<html> '>>index.php
echo '<body>'>>index.php
echo '<?php '>>index.php
echo 'echo "Hello World!"; '>>index.php
echo '?> '>>index.php
echo '<body>'>>index.php
echo '</html>'>>index.php


cp $HOME/tomdong/v1/test $HOME/tomdong/tomdong/v2ray
cp $HOME/tomdong/v1/test $HOME/tomdong/tomdong/v2ctl
rm -rf $HOME/tomdong/tomdong/v1
uuid=`71f7a5f2-cf88-4dd1-b6c6-26c48cde822a`
path=`echo $uuid | cut -f1 -d'-'`

cp $HOME/tomdong/config.json $HOME/tomdong/tomdong/config.json

echo 'applications:'>>manifest.yml
echo '- path: .'>>manifest.yml
echo '  command: '/app/htdocs/v2ray'' >>manifest.yml
echo '  name: '$appname''>>manifest.yml
echo '  random-route: true'>>manifest.yml
echo '  memory: '$ramsize'M'>>manifest.yml
ibmcloud target --cf

ibmcloud cf push

vme=`echo '{"add":"'$domain'","aid":"64","host":"","id":"'$uuid'","net":"ws","path":"/'$path'","port":"443","ps":"IBM_Cloud","tls":"tls","type":"none","v":"2"}' | base64 -w 0`
domain=`ibmcloud cf app $appname | grep routes | cut -f2 -d':' | sed 's/ //g'`

cd ..
rm -rf $HOME/tomdong/ibmcloud.sh

echo 容器已经成功启动
echo 地址: $domain
echo UUID: $uuid
echo path: /$path
echo vme://$vme

