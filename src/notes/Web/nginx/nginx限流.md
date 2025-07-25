# Nginx 限流

### 限流

nginx 共有三个模块是关于限流的

ngx_http_limit_conn_module

ngx_http_limit_req_module

ngx_stream_limit_conn_module

针对链接数的限流

```
# ngx_http_limit_conn_module 

http {
limit_conn_zone $binary_remote_addr zone=perip:10m;
limit_conn_zone $server_name zone=perserver:10m;

server {
    ...
    limit_conn perip 10;
    limit_conn perserver 100;
}

# 针对每个ip
# 针对每个虚拟主机

```



针对请求数的限流

```
# ngx_http_limit_req_module

http {
    limit_req_zone $binary_remote_addr zone=one:10m rate=1r/s;

    ...

    server {

        ...

        location /search/ {
            limit_req zone=one burst=5;
        }
```

这里需要注意的是浏览器的页面请求都是短链接，即每个连接只发送一个请求就断开了

针对指定 ip 限流

```
# http 配置

http {    
    geo $limit {
        default 0;
        58.33.6.114 1;
    }
    map $limit $limit_key {
        1 "";
        0 $remote_addr;
    }
    limit_req_zone $limit_key zone=mylimit:10m rate=10r/m;
    limit_req_status 429;
    }

# location 配置
location / {
    limit_req zone=mylimit burst=5 nodelay;
}

# 注意
如果是针对某些内部 ip 不限流，其他 ip 限流，那就将geo $limit 设置为 {default 1; ip 0;}
```









#### 参考

https://blog.csdn.net/qq_33525941/article/details/124532214

http://nginx.org/en/docs/