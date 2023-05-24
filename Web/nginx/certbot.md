



#### 操作

1、编辑nginx配置文件，添加以下内容

```
server {
    listen 80;
    server_name  gaia-rpc.qa.bianjie.ai;
        location / {
        proxy_set_header Host $host;
        proxy_pass hhttp://10.2.10.140$request_uri;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        }
}
```

2、执行 certbot --nginx，选中你设置的域名即可；