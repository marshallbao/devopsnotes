​         lsof(list open files)是一个列出当前系统打开文件的工具

lsof
COMMAND     PID        USER   FD      TYPE             DEVICE SIZE/OFF       NODE NAME

lsof输出各列信息的意义如下：
COMMAND：进程的名称 
PID：进程标识符
USER：进程所有者
FD：文件描述符，应用程序通过文件描述符识别该文件。如cwd、txt等 TYPE：文件类型，如DIR、REG等
TYPE：
DEVICE：指定磁盘的名称
SIZE：文件的大小
NODE：索引节点（文件在磁盘上的标识）
NAME：打开文件的确切名称

常用参数
lsof abc.txt 显示开启文件abc.txt的进程
lsof -c abc 显示abc进程现在打开的文件
lsof -c -p 1234 列出进程号为1234的进程所打开的文件
lsof -g gid 显示归属gid的进程情况
lsof +d /usr/local/ 显示目录下被进程开启的文件
lsof +D /usr/local/ 同上，但是会搜索目录下的目录，时间较长
lsof -d 4 显示使用fd为4的进程
lsof -i 用以显示符合条件的进程情况
lsof -i[46] [protocol][@hostname|hostaddr][:service|port]
  46 --> IPv4 or IPv6
  protocol --> TCP or UDP
  hostname --> Internet host name
  hostaddr --> IPv4地址
  service --> /etc/service中的 service name (可以不止一个)
  port --> 端口号 (可以不止一个)
  
实用命令
lsof `which httpd` //那个进程在使用apache的可执行文件
lsof /etc/passwd //那个进程在占用/etc/passwd
lsof /dev/hda6 //那个进程在占用hda6
lsof /dev/cdrom //那个进程在占用光驱
lsof -c sendmail //查看sendmail进程的文件使用情况
lsof -c courier -u ^zahn //显示出那些文件被以courier打头的进程打开，但是并不属于用户zahn
lsof -p 30297 //显示那些文件被pid为30297的进程打开
lsof -D /tmp 显示所有在/tmp文件夹中打开的instance和文件的进程。但是symbol文件并不在列

lsof -u1000 //查看uid是100的用户的进程的文件使用情况
lsof -utony //查看用户tony的进程的文件使用情况
lsof -u^tony //查看不是用户tony的进程的文件使用情况(^是取反的意思)
lsof -i //显示所有打开的端口
lsof -i:80 //显示所有打开80端口的进程
lsof -i -U //显示所有打开的端口和UNIX domain文件
lsof -i UDP@[url]www.akadia.com:123 //显示那些进程打开了到www.akadia.com的UDP的123(ntp)端口的链接
lsof -i tcp@ohaha.ks.edu.tw:ftp -r //不断查看目前ftp连接的情况(-r，lsof会永远不断的执行，直到收到中断信号,+r，lsof会一直执行，直到没有档案被显示,缺省是15s刷新)
lsof -i tcp@ohaha.ks.edu.tw:ftp -n //lsof -n 不将IP转换为hostname，缺省是不加上-n参数
  
  

恢复删除的文件/删除文件空间未释放


有些临时或日志文件占空间很大, 可能自动或人为rm删除, 但是文件还在被进程使用

这种误删, 磁盘空间不释放. 此时执行df命令看到的已使用空间是小于du 测出的使用空间.

正确的清理方法

所以清理这些已经打开的文件, 建议使用重新向, 不要直接rm

\> xxx.log

释放空间

如果文件已经删除, 以下是清理方法

\1. 重启服务

如果服务不可以随便重启, 使用其他方法

\2. 清空文件描述符

找出已经删除, 但是空间没有释放的文件

lsof [目录] | grep delete

使用重定向清空文件

\# 再次确认要清空文件

ls -l /proc/$PID/fd/$FD

\# $PID $FD 根据lsof填充

\>/proc/$PID/fd/$FD

例子:

\# lsof /opt | grep delete

COMMAND PID TID USER FD TYPE DEVICE SIZE/OFF NODE NAME

....

java 8284 root 7u REG 8,3 0 1231078519 /opt/zookeeper/zookeeper.out (deleted)

从例子可以看出, pid 是 8284, fd是7

第2列是pid 第4列是文件描述符, 如图中7w , 7是文件描述符, w是write(写入) 第7列是文件大小

\> /proc/8284/fd/7

清空后可以看到空间已经释放 文件清空后,其实仍然打开在写入, 时间长了还会占空间. 彻底清空需要方法一或方法三

\3. gdb关闭文件

使用gdb, 用系统调用, 关闭log文件. pid和fd查找方法同方法二, 只是没有清空文件的步骤

gdb -p $PID

call close($FD)

quit


恢复删除的文件

当Linux计算机受到入侵时，常见的情况是日志文件被删除，以掩盖攻击者的踪迹。管理错误也可能导致意外删除重要的文件，比如在清理旧日志时，意外地删除了数据库的活动事务日志。有时可以通过lsof来恢复这些文件。
当进程打开了某个文件时，只要该进程保持打开该文件，即使将其删除，它依然存在于磁盘中。这意味着，进程并不知道文件已经被删除，它仍然可以向打开该文件时提供给它的文件描述符进行读取和写入。除了该进程之外，这个文件是不可见的，因为已经删除了其相应的目录索引节点。
在/proc 目录下，其中包含了反映内核和进程树的各种文件。/proc目录挂载的是在内存中所映射的一块区域，所以这些文件和目录并不存在于磁盘中，因此当我们对这些文件进行读取和写入时，实际上是在从内存中获取相关信息。大多数与 lsof 相关的信息都存储于以进程的 PID 命名的目录中，即 /proc/1234 中包含的是 PID 为 1234 的进程的信息。每个进程目录中存在着各种文件，它们可以使得应用程序简单地了解进程的内存空间、文件描述符列表、指向磁盘上的文件的符号链接和其他系统信息。lsof 程序使用该信息和其他关于内核内部状态的信息来产生其输出。所以lsof 可以显示进程的文件描述符和相关的文件名等信息。也就是我们通过访问进程的文件描述符可以找到该文件的相关信息。
当系统中的某个文件被意外地删除了，只要这个时候系统中还有进程正在访问该文件，那么我们就可以通过lsof从/proc目录下恢复该文件的内容。 假如由于误操作将/var/log/messages文件删除掉了，那么这时要将/var/log/messages文件恢复的方法如下：
首先使用lsof来查看当前是否有进程打开/var/logmessages文件，如下：
\# lsof |grep /var/log/messages
syslogd 1283 root 2w REG 3,3 5381017 1773647 /var/log/messages (deleted)
从上面的信息可以看到 PID 1283（syslogd）打开文件的文件描述符为 2。同时还可以看到/var/log/messages已经标记被删除了。因此我们可以在 /proc/1283/fd/2 （fd下的每个以数字命名的文件表示进程对应的文件描述符）中查看相应的信息，如下：
\# head -n 10 /proc/1283/fd/2
Aug 4 13:50:15 holmes86 syslogd 1.4.1: restart.
Aug 4 13:50:15 holmes86 kernel: klogd 1.4.1, log source = /proc/kmsg started.
Aug 4 13:50:15 holmes86 kernel: Linux version 2.6.22.1-8 (root@everestbuilder.linux-ren.org) (gcc version 4.2.0) #1 SMP Wed Jul 18 11:18:32 EDT 2007 Aug 4 13:50:15 holmes86 kernel: BIOS-provided physical RAM map: Aug 4 13:50:15 holmes86 kernel: BIOS-e820: 0000000000000000 - 000000000009f000 (usable) Aug 4 13:50:15 holmes86 kernel: BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved) Aug 4 13:50:15 holmes86 kernel: BIOS-e820: 0000000000100000 - 000000001f7d3800 (usable) Aug 4 13:50:15 holmes86 kernel: BIOS-e820: 000000001f7d3800 - 0000000020000000 (reserved) Aug 4 13:50:15 holmes86 kernel: BIOS-e820: 00000000e0000000 - 00000000f0007000 (reserved) Aug 4 13:50:15 holmes86 kernel: BIOS-e820: 00000000f0008000 - 00000000f000c000 (reserved)
从上面的信息可以看出，查看 /proc/8663/fd/15 就可以得到所要恢复的数据。如果可以通过文件描述符查看相应的数据，那么就可以使用 I/O 重定向将其复制到文件中，如:
cat /proc/1283/fd/2 > /var/log/messages
对于许多应用程序，尤其是日志文件和数据库，这种恢复删除文件的方法非常有用。