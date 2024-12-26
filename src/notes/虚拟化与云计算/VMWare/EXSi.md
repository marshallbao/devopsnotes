常用命令

```
# 查看 cpu
esxcli hardware cpu list
# 查看内存
esxcli hardware memory get
esxcli hardware memory get | grep "Physical Memory" | awk '{print $3/1024/1024/1024 " GB"}'

# 查看硬盘
esxcli storage vmfs extent list

# 查看资源使用情况
esxtop
```

