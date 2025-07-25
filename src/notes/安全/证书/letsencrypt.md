# Let's Encrypt

Let's Encrypt 是一个由非营利性组织互联网安全研究小组（ISRG）提供的免费、自动化和开放的证书颁发机构（CA），简单的说，就是为网站提供免费的 SSL/TLS 证书。

互联网安全研究小组（ISRG）：ISRG是美国加利福尼亚州的一家公益公司，成立于2013年5月，第一个项目是Let's Encrypt证书颁发机构。

Let’s Encrypt 使用 ACME 协议来验证您对给定域名的控制权并向您颁发证书。

要获得 Let’s Encrypt 证书，您需要选择一个要使用的 ACME 客户端软件。

Let’s Encrypt 不控制或审查第三方客户端，也不能保证其安全性或可靠性。

官方推荐使用 Certbot 客户端来签发证书，官网：https://certbot.eff.org/

### certbot 配置证书

```
1. 安装工具
yum install certbot python2-certbot-nginx 

2. 编辑 nginx 配置文件
server {
        listen       80;
        listen       [::]:80;
        server_name  www.veryimportanteggs.com;
        root         /mnt/nginx/html;
}
3. 配置解析

4. 申请证书
certbot --nginx -d www.veryimportanteggs.com  -n  --agree-tos --preferred-challenges http --email contact@veryimportanteggs.com

5. 配置定时任务
0 1 1 * * certbot renew -q --post-hook 'systemctl reload nginx'

6. 最终的nginx配置文件
server {
        server_name  www.veryimportanteggs.com;
        root         /mnt/nginx/html;
    
    listen [::]:443 ssl ipv6only=on; # managed by Certbot
    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/www.veryimportanteggs.com/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/www.veryimportanteggs.com/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot

}
server {
    if ($host = www.veryimportanteggs.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


        listen       80;
        listen       [::]:80;
        server_name  www.veryimportanteggs.com;
    return 404; # managed by Certbot


}
```

certbot 其他命令

```
# 删除证书
certbot delete --cert-name three.rushout.asia

# 检查并更新证书
certbot renew

# 查看证书信息
certbot certificates

# 撤销证书
certbot revoke
```



### 其他相似工具

https://freessl.cn/

### 参考

https://blog.csdn.net/v6543210/article/details/128471767

https://blog.csdn.net/weixin_52851967/article/details/125960817