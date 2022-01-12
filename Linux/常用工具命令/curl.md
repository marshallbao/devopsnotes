​         Curl  
curl命令是一个利用URL规则在命令行下工作的文件传输工具。它支持文件的上传和下载，所以是综合传输工具，但按传统，习惯称curl为下载工具。
作为一款强力工具，curl支持包括HTTP、HTTPS、ftp等众多协议，还支持POST、cookies、认证、从指定偏移处下载部分文件、用户代理字符串、限速、文件大小、进度条等特征。
做网页处理流程和数据检索自动化，curl可以祝一臂之力。


常用选项：
-A/--user-agent <string>              设置用户代理发送给服务器
-b/--cookie <name=string/file>    cookie字符串或文件读取位置
-c/--cookie-jar <file>                    操作结束后把cookie写入到这个文件中
-C/--continue-at <offset>            断点续转
-d                                                以post方式传送数据
-D/--dump-header <file>              把header信息写入到该文件中
-e/--referer                                  来源网址
-f/--fail                                          连接失败时不显示http错误
-G                                                 以get的方式发送数据
-H                                                   自定义header
-i                                                   连同网页代码一起显示http response的头信息
-I                                                   只显示http response的头信息
-L                                                 追踪重定向（自动跳转）
-m                                                超时时间
-o/--output                                  把输出写到该文件中
-O/--remote-name                      把输出写到该文件中，保留远程文件的文件名
-r/--range <range>                      检索来自HTTP/1.1或FTP服务器字节范围
-s/--silent                                    静音模式。不输出任何东西
-S                                                显示错误信息
--trace/--trace-ascii                     可以查看更详细的过程
-T/--upload-file <file>                  上传文件
-u/--user <user[:password]>      设置服务器的用户和密码
-v                                               详细输出，包含请求和响应的首部
-w/--write-out [format]                什么输出完成后(控制额外输出)
-X                                                指定请求方式;POST,GET,DELETE
-x/--proxy <host[:port]>              在给定的端口上使用HTTP代理
-#/--progress-bar                        进度条显示当前的传送状态


实例：
1.只返回状态码
curl -I -m 15 -o /dev/null -s -w %{http_code} www.baidu.com
2.自定义显示文字和返回状态码
curl -I -m 15 -o /dev/null -s -w "我爱你：%{http_code}" www.baidu.com
3.抓取页面内容到一个文件中（test文件不需要创建）
curl -o test.html www.baidu.com
4、保存cookie信息
curl -c cookiec.txt  http://www.linux.com
5、使用-d发送带参数的请求（默认是post方式提交）
curl -d "cb=cb_1540200657317&cid=afbe8fd3d73448c9&interfaceCode=b5018a28d5f8609f&pid=92b01a8207f5c404" https://act.vip.iqiyi.com/api/process.action




附：官方文档
https://curl.haxx.se/docs/manpage.html
其他文档
https://www.cnblogs.com/duhuo/p/5695256.html