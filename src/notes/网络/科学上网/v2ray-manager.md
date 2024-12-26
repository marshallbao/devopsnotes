### 客户端

生成 uuid

```
uuidgen
```

组合 vmess 链接

```
root@bianJieBD-byg:~# cat vpn 
{
"v": "2",
"ps": "test2",
"add": "magicladder.info",
"port": "2053",
"id": "69ce26f3-bd8f-40ba-8800-5935621f9bcd",
"aid": "0",
"net": "ws",
"type": "none",
"host": "magicladder.info",
"path": "/",
"tls": "tls"
}
```

生成 vmess 链接

```
cat vpn|base64 -w 0 |xargs -i echo "vmess://{}"
```

导入客户端



### 服务器端

```
# 
jq '.inbounds[0].settings.clients +=[{ "name": "xxx","id": "69ce26f3-bd8f-40ba-8800-5935621f9bcd","level": 1,"alterId": 0 }]' config.json > tmp_config
# 
mv tmp_config config.json
# 
systemctl restart v2ray
```

