cURL 是一个利用URL语法在命令行下工作的文件传输工具


常用选项：

```
-A/--user-agent <string>          设置用户代理发送给服务器
-b/--cookie <name=string/file>    cookie字符串或文件读取位置
-c/--cookie-jar <file>            操作结束后把cookie写入到这个文件中
-C/--continue-at <offset>         断点续转
-d                                以post方式传送数据
-D/--dump-header <file>           把header信息写入到该文件中
-e/--referer                      来源网址
-f/--fail                         连接失败时不显示http错误
-G                                以get的方式发送数据
-H                                自定义header
-i                                连同网页代码一起显示 http response 的头信息
-I                                只显示http response的头信息
-L                                追踪重定向（自动跳转）
-m                                超时时间
-o/--output                       把输出写到该文件中
-O/--remote-name                  把输出写到该文件中，保留远程文件的文件名
-r/--range <range>                检索来自HTTP/1.1或FTP服务器字节范围
-s/--silent                       静音模式。不输出任何东西
-S                                显示错误信息
--trace/--trace-ascii             可以查看更详细的过程
-T/--upload-file <file>           上传文件
-u/--user <user[:password]>       设置服务器的用户和密码
-v                                详细输出，包含请求和响应的首部
-w/--write-out [format]           什么输出完成后(控制额外输出)
-X                                指定请求方式;POST,GET,DELETE
-x/--proxy <host[:port]>          在给定的端口上使用HTTP代理
-#/--progress-bar                 进度条显示当前的传送状态
```



常用实例：

只返回状态码

```
curl -I https://www.baidu.com
```

显示请求头和响应头等详细信息

```
# -v：> 表示请求， < 表示响应
curl -I -v https://www.baidu.com
```

使用 body 请求

```
# 默认 Content-Type:text/plain
curl -X "POST" -d “interfaceCode=b5018a&pid=92b01a820" https://act.vip.iqiyi.com/api/process.action

# 指定请求头 Content-Type:application/json
curl -XPOST -H "Content-Type:application/json" -d '{"downloadUrl": "https://d.bianjie.ai/A-Bank.apk"}' http:// 218.2.111.130:13000/reinforce
```

使用 query 请求

```
curl -X "GET" https://act.vip.iqiyi.com/api/process.action?interfaceCode=b5018a&pid=92b01a820
```

自定义字段显示

```
curl -o /dev/null -s -w 'DNS解析时长：%{time_namelookup}\n建立tcp时长：%{time_connect}\n客户端到服务器时长：%{time_starttransfer}\n从开始到结束时长：%{time_total}\n下载速度：%{speed_download}\n' http://www.baidu.com
```

显示下载进度

```
# O 保留远端文件名字，o 保存到指定文件
curl -O -# https://d.bianjie.ai/asiadb-app/A-Bank-v1.6.0-appstore-16-202206061022.ipa
curl -o xx -# https://d.bianjie.ai/asiadb-app/A-Bank-v1.6.0-appstore-16-202206061022.ipa
```

登录

```
curl -u name:passwd https://gitlab.bianjie.ai
```

参考
https://curl.haxx.se/docs/manpage.html
https://www.cnblogs.com/duhuo/p/5695256.html