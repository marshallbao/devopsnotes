配置文件总览

nginx.conf

```
worker_processes  auto;

error_log  /var/log/nginx/error.log warn;
pid        /var/run/nginx.pid;

events {
    worker_connections  1024;
}

http {
    include       /etc/nginx/mime.types;
    default_type  application/octet-stream;

    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    sendfile        on;
    #tcp_nopush     on;

    keepalive_timeout  65;

    #gzip  on;

    include /etc/nginx/conf.d/*.conf;
}

stream{
    include /etc/nginx/conf.d/*.stream;
}
```

test.conf

```
server {
    listen       80;
    server_name  grafana.cschain.tech; 
    root         /usr/share/nginx/html;
    
    location / {
    proxy_pass http://10.0.4.49$request_uri;
    }
}
```

test.stream

```
upstream uidg {
        hash $remote_addr consistent;
        server 10.0.4.49:30890 weight=1 max_fails=3 fail_timeout=30s;
}

server {
       listen       30890;
       proxy_pass uidg;
}
```



### 配置文件的主要模块

全局配置块：最顶层，包含所有其他模块

Event 模块：直接从属于全局配置块

HTTP 模块：直接从属于全局配置块，包含 Server 模块、upstream 块等。

Server 模块：从属于 HTTP 模块，包含 Location 模块

upstream 模块：从属于 HTTP 模块

Location 模块：从属于 Server 模块，用于处理特定的 URI。

stream 模块：直接从属于全局配置块



### 注意

1 个 nginx 只能有  1 个  http 模块和一个 stream 模块.