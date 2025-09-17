# EXSi

可以 web 登录也可以命令行 ssh 登录（ 需要在 web 页面将 ssh 服务开启，才能命令行登录）



### 常用命令

```
## esxcli 相关
# 查看 cpu
esxcli hardware cpu list
# 查看内存
esxcli hardware memory get
esxcli hardware memory get | grep "Physical Memory" | awk '{print $3/1024/1024/1024 " GB"}'

# 查看硬盘
esxcli storage vmfs extent list

# 查看进程
esxcli vm process list

# 查看资源使用情况
esxtop


## vim-cmd 虚拟机相关
# 查看虚拟机
vim-cmd vmsvc/getallvms

# 查看虚拟机状态
vim-cmd vmsvc/power.getstate <vmid>

# 查看虚拟机详细信息
vim-cmd vmsvc/get.summary <vmid>
```

