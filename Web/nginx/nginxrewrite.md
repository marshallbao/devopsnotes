### URL Rewrite

1、什么是地址重写？
  Rewrite又称URL Rewrite，即URL重写，就是把传入Web的请求重定向到其他URL的过程。

2、应用场景
  伪静态化，是将动态页面显示为静态页面方式的一种技术。理论上，搜索引擎更喜欢静态页面形式的网页，搜

索引擎对静态页面的评分一般要高于动态页面。所以，URL Rewrite可以让我们网站的网页更容易被搜索引擎所收录。
  提高安全性，如果在URL中暴露太多的参数，无疑会造成一定量的信息泄漏，可能会被一些黑客利用，对你的系统造成一定的破坏，所以静态化的URL地址可以给我们带来更高的安全性。

  美化URL，去除一些后缀名或参数串，让网页的地址看起来尽可能简洁明快，有利于反映访问模块内容。

  实现地址跳转、协议跳转、端口跳转。




### location与rewrite的联系和区别 

rewrite ：对访问的域名或者域名内的URL路径地址重写
location：对访问的路径做访问控制或者代理转发

 从功能看 rewrite 和 location 似乎有点像，都能实现跳转，主要区别在于 rewrite 是在同一域名内更改获取资源的路径，而 location 是对一类路径做控制访问或反向代理，还可以proxy_pass 到其他机器。


### 参考

https://blog.csdn.net/weixin_43898125/article/details/108069874

https://blog.csdn.net/qq_62462797/article/details/127196144