

# SELinux

三种状态

enforcing - 表示已强制执行SELinux安全策略

permissive - 表示SELinux记录警告信息而不是执行操作

disabled - 表示没有加载SELinux策略

查看状态

getenforce

设置状态

```
命令，临时修改
setenforce 0
修改配置文件，重启机器永久修改
vim /etc/selinux/config
SELINUX=disabled 
reboot
```



### 防火墙

systemctl status firewalld
systemctl stop firewalld
systemctl disable firewalld