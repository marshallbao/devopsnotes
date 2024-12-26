### nginx 压缩

nginx 默认安装ngx_http_gzip_module,采用的是chunked方式的动态压缩，静态压缩需要使用http_gzip_static_module这个模块，进行pre-compress

动态压缩：每次请求都现压缩

静态压缩：提前将文件压缩好，保存在服务端，类似 xx.png.gz，直接请求即可，没有 .gz 格式的文件就会自动返

回原文件

#### 配置

```
# 场景1、已经压缩好文件，只需要开启静态压缩
  gzip_static  on;

# 场景2、没有压缩好的文件，需要开启动态压缩
  gzip  on;
  gzip_types application/javascript text/css;
  gzip_min_length 1k;
```

#### 注意

gzip_static 配置优先级高于gzip

开启 nginx_static 后，对于任何文件都会先查找是否有对应的gz文件

gzip_types 设置对 gzip_static 无效

gzip_static 默认适用HTTP 1.1

#### 参考

https://blog.csdn.net/qq_59636442/article/details/124078426

https://blog.csdn.net/qq_22188085/article/details/115768233

https://www.cnblogs.com/Renyi-Fan/p/11047490.html



### nginx 缓存

nginx 可配置的缓存又有2种

客户端的缓存(一般指浏览器的缓存)

服务端/代理端的缓存(使用proxy-cache实现的)

协商缓存和强制缓存



#### 相关参数

```
# 
Cache-Control
max-age: 标识资源能够被缓存的最大时间
public: 表示该响应任何中间人，包括客户端和代理服务器都可以缓存
private: 表示该响应只能用于浏览器私有缓存中，中间人（代理服务器）不能缓存此响应
no-cache: 需要使用对比缓存（Last-Modified/If-Modified-Since/Etag/If-None-Match）来验证缓存数据
no-store: 所有内容都不会缓存，强制缓存和对比缓存都不会触发

# 协商缓存相关参数
Last-Modified
位置: HTTP Response Header
说明: 第一次请求时，服务器会在响应头里设置该参数，告诉浏览器该资源的最后修改时间。

If-Modified-Since
位置: HTTP Request Header
说明: 再次（注意不是第一次）请求服务器时，客户端浏览器通过此字段通知服务器上次请求时，服务器返回的资源最后修改时间。服务器收到请求后，发现 header 中有 If-Modified-Since 字段，则与被请求资源的最后修改时间进行对比。若资源的最后修改时间大于 If-Modified-Since，则说明资源被修改过，则响应返回完整的内容，返回状态码 200。若资源的最后修改时间小于或等于 If-Modified-Since，则说明资源未修改，则返回 304 状态码，告诉浏览器继续使用所保存的缓存数据。

Etag
位置: HTTP Response Header
说明: 服务器响应请求时，告诉浏览器当前资源在服务器的唯一标识（由服务端生成）。
优先级: 高于 Last-Modified 与 If-Modified-Since

If-None-Match
位置: HTTP Request Header
说明: 再次请求服务器时，通过此字段通知服务器客户端缓存的资源的唯一标识。服务器收到请求 header 周发现有 If-None-Match 字段，则与被请求资源的唯一标识进行对比。如果不一样，说明资源被修改过，则返回完整的响应，状态码 200。如果一样，说明资源未被修改过，则返回 304 状态码，告诉浏览器继续使用缓存的数据。
```









#### 参考

https://www.cnblogs.com/itzgr/p/13321980.html































