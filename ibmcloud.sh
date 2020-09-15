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


cp $HOME/tomdong/v1/test $HOME/tomdong/tomdong/test01
cp $HOME/tomdong/v1/v2ctl $HOME/tomdong/tomdong/v2ctl


rm -rf $HOME/tomdong/tomdong/v1
uuid=`cat /proc/sys/kernel/random/uuid`
path=`echo $uuid | cut -f1 -d'-'`

echo 'applications:'>>manifest.yml
echo '- path: .'>>manifest.yml
echo '  command: '/app/htdocs/test01'' >>manifest.yml
echo '  name: '$appname''>>manifest.yml
echo '  random-route: true'>>manifest.yml
echo '  memory: '$ramsize'M'>>manifest.yml
ibmcloud target --cf

ibmcloud cf push

domain=`ibmcloud cf app $appname | grep routes | cut -f2 -d':' | sed 's/ //g'`

cd ..
rm -rf $HOME/tomdong/ibmcloud.sh

echo 容器已经成功启动
echo 地址: $domain
echo UUID: $uuid
echo path: /$path
echo vme://$vme

