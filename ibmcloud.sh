#!/bin/sh
	appname=redruddy0913

	ramsize=256

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

wget https://github-production-release-asset-2e65be.s3.amazonaws.com/41912791/f9a32880-ed44-11ea-9636-99a29727a9f6?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20200915%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20200915T072659Z&X-Amz-Expires=300&X-Amz-Signature=41881e8da3f08c06578fa6cf1a2090bcb2cb63b91f5d4080569b7fe695c978af&X-Amz-SignedHeaders=host&actor_id=43061674&key_id=0&repo_id=41912791&response-content-disposition=attachment%3B%20filename%3Dv2ray-linux-64.zip&response-content-type=application%2Foctet-stream
unzip -d v1 v2ray-linux-64.zip
cd v1
chmod 777 *
cd ..
rm -rf v2ray-linux-64.zip
mv $HOME/tomdong/tomdong/v1/v2ray $HOME/tomdong/tomdong/test
mv $HOME/tomdong/tomdong/v1/v2ctl $HOME/tomdong/tomdong/v2ctl
rm -rf $HOME/tomdong/tomdong/v1
uuid=`cat /proc/sys/kernel/random/uuid`
path=`echo $uuid | cut -f1 -d'-'`
echo '{"inbounds":[{"port":8080,"protocol":"vmess","settings":{"clients":[{"id":"'$uuid'","alterId":64}]},"streamSettings":{"network":"ws","wsSettings":{"path":"/'$path'"}}}],"outbounds":[{"protocol":"freedom","settings":{}}]}'>$HOME/tomdong/tomdong/config.json
echo 'applications:'>>manifest.yml
echo '- path: .'>>manifest.yml
echo '  command: '/app/htdocs/test'' >>manifest.yml
echo '  name: '$appname''>>manifest.yml
echo '  random-route: true'>>manifest.yml
echo '  memory: '$ramsize'M'>>manifest.yml
ibmcloud target --cf

ibmcloud cf push

domain=`ibmcloud cf app $appname | grep routes | cut -f2 -d':' | sed 's/ //g'`
vmess=`echo '{"add":"'$domain'","aid":"64","host":"","id":"'$uuid'","net":"ws","path":"/'$path'","port":"443","ps":"IBM_Cloud","tls":"tls","type":"none","v":"2"}' | base64 -w 0`
cd ..
echo 容器已经成功启动
echo 地址: $domain
echo UUID: $uuid
echo path: /$path
echo vmess://$vmess
