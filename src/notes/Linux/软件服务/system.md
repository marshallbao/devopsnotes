linux7 之后服务管理是 systemctl

运行级别 ？

​	查看运行级别：systemctl get-default

​    第三方服务：/usr/lib/systemd/system

​    系统服务：/etc/systemd/system/(优先级更高)

常用命令

```
启动
systemctl start docker

停止
systemctl stop docker

重启
systemctl restart docker

查看状态
systemctl status docker

设置开机启动
systemctl enable docker

去掉开机启动
systemctl disable docker

重载
systemctl daemon-reload

#屏蔽 unit，屏蔽后 unit 无法启动
systemctl mask chronyd 

#取消屏蔽
systemctl unmask chronyd 

放弃加载失败的服务，主要用于删除服务时
systemctl reset-failed

列出所有已经加载的 systemd units
systemctl
systemctl | grep docker.service

列出所有 service
systemctl list-units --type=service
systemctl --type=service

列出所有active状态（运行或退出）的服务
systemctl list-units --type=service --state=active

列出所有正在运行的服务
systemctl list-units --type=service --state=running

列出所有正在运行或failed状态的服务
systemctl list-units --type service --state running,failed

列出所有启动文件
systemctl list-unit-files

列出所有enabled状态的服务
systemctl list-unit-files --state=enabled

查看某个服务是否开机启动
systemctl is-enabled  docker

查看某个服务是否在运行
systemctl is-active docker

```

