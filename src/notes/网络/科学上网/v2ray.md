# V2ray

架构

client --> cloudflare --> 域名 --> nginx+ssl --> ws+ssl+v2ray 



下载安装

```
$ bash <(curl -s -L https://git.io/v2ray.sh)
```

配置

```
选择传输协议
选择自定义端口
输入域名
自动配置 TLS
网站伪装 和 路径分流(路径随便写个)
伪装的网址默认
接下来默认就好了
```



注意：因为选择了自动配置 TLS ，所以是下载安装了 caddy 服务，所以要卸载掉 find / -name "*caddy*" -delete

配置 nginx +tls

这里用的是 nginx + certbot

安装

```
安装 nginx
yum install nginx

安装 certbot
yum install certbot python2-certbot-nginx

配置 v2ray.conf
vim /etc/nginx/conf.d/v2ray.conf
server {
    server_name magicladder.info;

    listen 23334;
    location / {
        proxy_pass http://10.140.15.198:23333;
        proxy_http_version 1.1;
        proxy_redirect off;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $http_host;

        # Show realip in v2ray access.log
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

    }

}

使用 certbot 生成证书
certbot --nginx -d magicladder.info  -n  --agree-tos --preferred-challenges http --email ops@bianjie.ai

```



最终的 v2ray.conf

```
server {
    server_name magicladder.info;

    listen 23334 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/magicladder.info/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/magicladder.info/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
    location / {
        proxy_pass http://10.140.15.198:23333;
        proxy_http_version 1.1;
        proxy_redirect off;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $http_host;

        # Show realip in v2ray access.log
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

    }

}
```

常用命令

```
管理服务
v2ray

查看url
v2ray url

查看信息
v2ray info

修改配置
v2ray config
```





参考：

https://blog.upx8.com/2882

客户端

https://itlanyan.com/v2ray-clients-download/

https://www.v2ray.com/awesome/tools.html

官网

https://www.v2ray.com/

