日志分两类，一类是 Docker 引擎日志,另一类捕获的容器日志

**Docker 引擎日志**

Docker 引擎日志 一般是交给了 Upstart(Ubuntu 14.04) 或者 systemd (CentOS 7, Ubuntu 16.04)。前者一般位于 /var/log/upstart/docker.log 下，后者一般通过 jounarlctl -u docker 来读取。不同系统的位置都不一样，SO上有人总结了一份列表，我修正了一下，可以参考：

| 系统                   | 日志位置                                                     |
| ---------------------- | ------------------------------------------------------------ |
| Ubuntu(14.04)          | /var/log/upstart/docker.log                                  |
| Ubuntu(16.04)          | journalctl -u docker.service                                 |
| CentOS 7/RHEL 7/Fedora | journalctl -u docker.service                                 |
| CoreOS                 | journalctl -u docker.service                                 |
| OpenSuSE               | journalctl -u docker.service                                 |
| OSX                    | ~/Library/Containers/com.docker.docker/Data/com.docker.driver.amd64-linux/log/d‌ocker.log |
| Debian GNU/Linux 7     | /var/log/daemon.log                                          |
| Debian GNU/Linux 8     | journalctl -u docker.service                                 |
| Boot2Docker            | /var/log/docker.log                                          |



**捕获的容器日志**

容器日志是容器打印到标准输出（控制台，console）的日志；
以json-file为例：
它储存在/var/lib/docker/containers/<容器id>/<容器id>-json.log 下，可以通过docker logs  来查看

***docker log driver***

| 驱动程序   | 描述                                                         |
| ---------- | ------------------------------------------------------------ |
| none       | 容器没有日志可用，docker logs 什么都不返回                   |
| json-file  | 日志格式化为 JSON。这是 Docker 默认的日志驱动程序。          |
| syslog     | 将日志消息写入 syslog 工具。syslog 守护程序必须在主机上运行。 |
| journald   | 将日志消息写入 journald。journald 守护程序必须在主机上运行。 |
| gelf       | 将日志消息写入 Graylog Extended Log Format (GELF) 终端，例如 Graylog 或 Logstash。 |
| fluentd    | 将日志消息写入 fluentd（forward input）。fluentd 守护程序必须在主机上运行。 |
| awslogs    | 将日志消息写入 Amazon CloudWatch Logs。                      |
| splunk     | Writes log messages to splunk using the HTTP Event Collector. |
| etwlogs    | 将日志消息写为 Windows 的 Event Tracing 事件。仅在Windows平台上可用。 |
| gcplogs    | 将日志消息写入 Google Cloud Platform (GCP) Logging。         |
| logentries | 将日志消息写入 Rapid7 Logentries。                           |



我们可以在 docker run 命令中通过  --log-driver 参数来设置具体的 Docker 日志驱动，也可以通过 --log-opt 参数来指定对应日志驱动的相关选项。就拿 json-file 来说，其实可以这样启动 Docker 容器：

`docker run \-d \-p 80:80 \--log-driver json-file \--log-opt max-size=10m \--log-opt max-file=3 \--name nginx \nginx`通过 --log-opt 参数为 json-file 日志驱动添加了两个选项，max-size=10m 表示  JSON 文件最大为 10MB（超过 10MB 就会自动生成新文件），max-file=3 表示 JSON 文件最多为3个（超过3个就会自动删除多余的旧文件）