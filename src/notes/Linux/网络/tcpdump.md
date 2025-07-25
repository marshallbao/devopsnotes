# tcpdump

### 常用

```
tcpdump -i eth0

tcpdump -i any  port 25557 -nn

tcpdump -i any host 10.24.10.56 -nn and port 5557

tcpdump -i any icmp
```

### 小技巧

在有其他流量干扰的情况下尽量将抓包的目标明确比如主机 协议 端口等

### 参考

https://cloud.tencent.com/developer/article/1858612