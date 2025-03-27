# syslog

### syslog.conf 介绍

   对于不同类型的Unix，标准UnixLog系统的设置，实际上除了一些关键词的不同，系统的syslog.conf格式是相同的。syslog采用可配置的、统一的系统登记程序，随时从系统各处接受log请求，然后根据/etc/syslog.conf中的预先设定把log信息写入相应文件中、邮寄给特定用户或者直接以消息的方式发往控制台。值得注意的是，为了防止入侵者修改、删除messages里的记录信息，可以采用用打印机记录或采用方式来挫败入侵者的企图。

### syslog.conf 格式

可以参考man [5] syslog.conf。这里是对syslog.conf的简单介绍

 /etc/syslog.conf文件中的一项配置记录由“选项”(selector)和“动作”(action)两个部分组成，两者间用tab制表符

进 行分隔(使用空格间隔是无效的)。而“选项”又由一个或多个形如“类型.级别”格式的保留字段组合而成，各保留字

段间用分号分隔。如下行所示：
    类型.级别 [；类型.级别] `TAB` 动作

2.1 类型 
​    保留字段中的“类型”代表信息产生的源头，可以是：
​    auth    认证系统，即询问用户名和口令
​    cron    系统定时系统执行定时任务时发出的信息
​    daemon  某些系统的守护程序的syslog,如由in.ftpd产生的log
​    kern    内核的syslog信息
​    lpr     打印机的syslog信息
​    mail    邮件系统的syslog信息
​    mark    定时发送消息的时标程序
​    news    新闻系统的syslog信息
​    user    本地用户应用程序的syslog信息
​    uucp    uucp子系统的syslog信息
​    local0..7 种本地类型的syslog信息,这些信息可以又用户来定义
​    \*       代表以上各种设备

2.2 级别
​    保留字段中的“级别”代表信息的重要性，可以是：
​    emerg   紧急，处于Panic状态。通常应广播到所有用户； 
​    alert   告警，当前状态必须立即进行纠正。例如，系统数据库崩溃； 
​    crit    关键状态的警告。例如，硬件故障； 
​    err     其它错误； 
​    warning 警告； 
​    notice  注意；非错误状态的报告，但应特别处理； 
​    info    通报信息； 
​    debug   调试程序时的信息； 
​    none    通常调试程序时用，指示带有none级别的类型产生的信息无需送出。如*.debug;mail.none表示调试时除邮件信息外其它信息都送出。

2.3 动作
​    “动作”域指示信息发送的目的地。可以是： 
​    /filename   日志文件。由绝对路径指出的文件名，此文件必须事先建立； 
​    @host       远程主机； @符号后面可以是ip,也可以是域名，默认在/etc/hosts文件下loghost这个别名已经指定给了本机。
​    user1,user2 指定用户。如果指定用户已登录，那么他们将收到信息； 
​    \*           所有用户。所有已登录的用户都将收到信息。

### 具体实例

​    我们来看看/etc/syslog.conf文件中的实例： 

```
*.err;kern.debug;daemon.notice;mail.crit    [TAB]   /var/adm/messages 

这行中的“action”就是我们常关心的那个 /var/adm/messages文件
输出到它的信息源头 “selector”是： 
*.err - 所有的一般错误信息； 
kern.debug - 核心产生的调试信息； 
daemon.notice - 守护进程的注意信息； 
mail.crit - 邮件系统的关键警告信息
```

### syslog.conf 内容

日志文件由系统日志和内核日志监控程序syslogd 与klogd 控制, 在/etc/syslog.conf 文件中配置这两个监控程序默认活动。

日志文件按/etc/syslog.conf 配置文件中的描述进行组织。以下是/etc/syslog.conf 文件的内容：

```
[root@FlowServer syslog]# cat /etc/syslog.conf 
\# Log all kernel messages to the console.
\# Logging much else clutters up the screen.
\#kern.*                                                 /dev/console
local4.info                                             @1.1.1.2
\# Log anything (except mail) of level info or higher.
\# Don't log private authentication messages!
\#*.info;mail.none;authpriv.none;cron.none;local5.none  /var/log/messages
*.info;mail.none;authpriv.none;cron.none;local5.none  /var/log/messages
\# The authpriv file has restricted access.
authpriv.*                                              /var/log/secure

\# Log all the mail messages in one place.
mail.*                                                  -/var/log/maillog
user.err                                                /var/log/user_test.log

\# Log cron stuff
cron.*                                                  /var/log/cron

\# Everybody gets emergency messages
*.emerg                                                 *

\# Save news errors of level crit and higher in a special file.
uucp,news.crit                                          /var/log/spooler

\# Save boot messages also to boot.log
local7.*                                                /var/log/boot.log

\#mydata
local5.*                                                /var/log/ys.log
syslog.*                                                @172.25.25.36
```

### 版本

Syslog机制是类unix系统中经常使用的一种日志记录方式。它能够以多种级别组合记录系统运行过程中各类日志信息。比如内核运行信息日志，程序运行 输出的日志等。在为嵌入式系统做开发时，将程序运行时的一些重要信息写入日志中，对于程序的调试以及错误诊断帮助是非常大的。重要信息包括程序运行时的重 要变量，函数运行结果，错误记录等等。对于嵌入式系统而言，由于系统资源有限，而且是交叉开发，调试及诊断及其不便。使用syslog机制，可大大简化这 些工作。

并不是所有嵌入式系统都可以使用syslog。首先，系统使用类unix操作系统，常用的就是linux。其次，为了支持远程日志记录，系统中必须支持网络通信。所幸，目前大部分嵌入式系统都是基于linux，并且支持网络。以下论述具体实现。

在编译busybox时，选择syslog应用程序，并将busybox加入到linux的文件系统中去。嵌入式系统启动后，就可以配置syslog的客 户端。根据busybox版本，syslog的服务进程syslogd的配置有所不同。早期的syslogd忽略syslog.conf文件内的配置项， 直接使用命令参数进行配置。新版本的syslogd支持使用syslog.conf文件进行配置。可以通过syslogd –h察看帮助信息，以确定当前的syslogd版本。

当不支持syslog.conf配置时，直接使用命令参数，输入以下命令启动syslogd:

 syslogd -n -m 0 -L -R 192.190.1.88

其中-n选项表示进程在前台运行。

-m 选项指定循环间隔时间。
-L 选项表示在进行远程日志记录的同时，本地也进行记录。如果不加该选项，则只进行远程日志记录。
-R 表示进行远程日志记录，将syslog日志发送到目标服务器上。这里假定目标服务器为的IP地址为192.190.1.88。如果不指定端口，默认使用UDP端口514。所以要确保服务器上该端口没用被占用。
启动后，所有的日志信息都会发往服务器的UDP端口514。

当支持syslog.conf配置时，只需修改该配置文件即可。在文件中增加以下语句：
*.*    @192.190.1.88
以 上配置表示将所有syslog的日志发往服务器192.190.1.88，使用默认的UDP端口。由于syslog.conf配置相对比较灵活，可以设置 屏蔽一些不需要的信息，以及设置指定的端口等等。请参考syslog.conf的有关命令，自行研究。然后启动 syslogd 即可进行远程记录