# Logrotate

滚动日志时不影响程序正常的日志输出

方案1：create 

create 是默认方案，与方案2  copytruncate 互斥；

这个方案的思路是重命名原日志文件，创建新的日志文件。详细步骤如下：

1. 重命名程序当前正在输出日志的程序。因为重命名只会修改目录文件的内容，而进程操作文件靠的是inode编号，所以并不影响程序继续输出日志。
2. 创建新的日志文件，文件名和原来日志文件一样。虽然新的日志文件和原来日志文件的名字一样，但是inode编号不一样，所以程序输出的日志还是往原日志文件输出。
3. 通过某些方式通知程序，重新打开日志文件。程序重新打开日志文件，靠的是文件路径而不是inode编号，所以打开的是新的日志文件。

什么方式通知程序重新打开日志呢？

1、简单粗暴的方法是杀死进程重新打开。很多场景这种作法会影响在线的服务，

2、有些程序提供了重新打开日志的接口，比如可以通过信号通知nginx。各种IPC方式都可以，前提是程序自身要支持这个功能。

方案2：copytruncate

如果程序不支持重新打开日志的功能，又不能粗暴地重启程序，怎么滚动日志呢？

这个方案的思路是把正在输出的日志拷(copy)一份出来，再清空(trucate)原来的日志。详细步骤如下：

1. 拷贝程序当前正在输出的日志文件，保存文件名为滚动结果文件名。这期间程序照常输出日志到原来的文件中，原来的文件名也没有变。
2. 清空程序正在输出的日志文件。清空后程序输出的日志还是输出到这个日志文件中，因为清空文件只是把文件的内容删除了，文件的inode编号并没有发生变化，变化的是元信息中文件内容的信息，结果上看，旧的日志内容存在滚动的文件里，新的日志输出到空的文件里。实现了日志的滚动。

总结：
    1、copytruncate 有丢失部分日志内容的风险，能用 create 的方案就别用 copytruncate；
    2、程序写日志的方式，都是用 O_APPEND 的方式写的，可以让 logroate 清空日志文件后，程序输出的日志都是从文件开始处开始写；

示例 1：使用 logrotate 切割日志

```
[root@app-mongodb-1 logrotate.d]# cat mongodb 
/var/log/mongodb/mongod.log
{
    missingok # 如果日志文件不存在，不报错，继续执行
    daily # 每天检测一次
    dateext # 轮转后的文件名加上日期后缀
    copytruncate # 模式
    rotate 30 # 保留多少个文件
    notifempty # 如果日志文件为空，则不切割。
    size 100M # 日志文件超过 100M 时触发切割
}

```



示例 2：使用 logrotate 压缩处理多个日志

```
/var/log/remote/10.0.1.2/*.log
{
    compress
    delaycompress
    missingok
    notifempty
    rotate 100
    daily
    dateext
}
```



### 其他命令

```
# 模拟执行
logrotate --debug /etc/logrotate.d/remote-logs

# 强制执行
logrotate -f /etc/logrotate.d/rsyslog
```

