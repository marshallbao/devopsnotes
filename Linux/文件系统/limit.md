## Linux系统中打开的文件描述符的最大数量

一共有

[root@localhost ~]# cat /proc/sys/fs/file-max 

这表明这台Linux系统最多允许同时打开(即包含所有用户打开文件数总和)12158个文件，是Linux系统级硬限制，所有用户级的打开文件数限制 都不应超过这个数值。
通常这个系统级硬限制是Linux系统在启动时根据系统硬件资源状况计算出来的最佳的最大同时打开文件数限制，如果没有特殊需要，不应该修改此限制，除非想为用户级打开文件数限制设置超过此限制的值。
修改此硬限制的方法是修改/etc/rc.local脚本，在脚本中添加如下行：echo 22158 > /proc/sys/fs/file-max这是让Linux在启动完成后强行将系统级打开文件数硬限制设置为22158。修改完后保存此文件

查看系统允许 当前用户进程打开的文件数限制
[speng@as4 ~]$ ulimit -n

修改Linux系统对用户的关于打开文件数的软限制和硬限制。
第一步，修改/etc/security/limits.conf文件，在文件中添加如下行：
\* soft nofile 10240
\* hard nofile 10240
其中speng指定了要修改哪个用户的打开文件数限制，可用'*'号表示修改所有用户的限制；soft或hard指定要修改软限制还是硬限制；10240则指定了想要修改的新的限制值，即最大打开文件数(请注意软限制值要小于或等于硬限制)。修改完后保存文件。
然后执行 sysctl -p,然后重新登录即可

查看进行打开了多少文件

[speng@as4 ~]$ ps -ef|grep gaia
20822
[speng@as4 ~]$ cat /proc/20822/limit |grep file

除了系统和用户，system 管理系统也会限制进程打开文件的数量，默认设置为1024；
修改方法：
1、
在service文件中添加 
[service]
LimitNOFILE=100000
reload 
systemctl daemon-reload
restart service
systemctl reload/restart xxxxx
2、
修改服务的【默认】配置

cat /etc/systemd/system.conf