常用日志格式：

​    log_format main '$remote_addr - $remote_user [stime_local] $request' '"$status" $body_bytes_sent "$http_referer"' '"$http_user_agent" "$http_x_forwarded_for"'
​    
记录真实的客户端ip:
​    log_format main '$proxy_add_x_forwarded_for - $remote_user [$time_local]' '"$request" $status $body_bytes_sent' '"$http_referer" "$http_user_agent"';

相关参数：
$stime_local：时间;
$http_x_forwarded_for：访问用户的真实 IP 地址;
$remote_addr, $http_x_forwarded_for 记录客户端IP地址
$remote_user 记录客户端用户名称
$request 记录请求的URL和HTTP协议
$status 记录请求状态
$body_bytes_sent 发送给客户端的字节数，不包括响应头的大小； 该变量与Apache模块mod_log_config里的“%B”参数兼容。
$bytes_sent 发送给客户端的总字节数。
$connection 连接的序列号。
$connection_requests 当前通过一个连接获得的请求数量。
$msec 日志写入时间。单位为秒，精度是毫秒。
$pipe 如果请求是通过HTTP流水线(pipelined)发送，pipe值为“p”，否则为“.”。
$http_referer 记录从哪个页面链接访问过来的
$http_user_agent 记录客户端浏览器相关信息
$request_length 请求的长度（包括请求行，请求头和请求正文）。
$request_time 请求处理时间，单位为秒，精度毫秒； 从读入客户端的第一个字节开始，直到把最后一个字符发送给客户端后进行日志写入为止。
$time_iso8601 ISO8601标准格式下的本地时间。
$time_local 通用日志格式下的本地时间。