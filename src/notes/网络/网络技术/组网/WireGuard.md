# WireGuard

概念

[WireGuard](https://www.wireguard.com/) 是一个易于配置、快速且安全的开源 [VPN](https://en.wikipedia.org/wiki/Virtual_private_network)，它利用了最新的加密技术。目的是提供一种更快、更简单、更精简的通用 VPN，它可以轻松地在树莓派这类低端设备到高端服务器上部署。

命令

```
# 启动
wg-quick up xx

# 停止
wg-quick down xx

# 状态查看
wg-quick down xx
```

配置文件

/etc/wireguard/xx.cnf

```
[Interface]
PrivateKey = oMWHSdVyXGWJ+K
Address = 192.168.100.3
# 连接后使用的 DNS, 如果要防止 DNS 泄露，建议使用内网的 DNS 服务器
DNS = 192.168.0.3  
PostUp   = iptables -A FORWARD -i %i -j ACCEPT; iptables -A FORWARD -o %i -j ACCEPT; iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE; ip6tables -A FORWARD -i %i -j ACCEPT; ip6tables -A FORWARD -o %i -j ACCEPT; ip6tables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
PostDown = iptables -D FORWARD -i %i -j ACCEPT; iptables -D FORWARD -o %i -j ACCEPT; iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE; ip6tables -D FORWARD -i %i -j ACCEPT; ip6tables -D FORWARD -o %i -j ACCEPT; ip6tables -t nat -D POSTROUTING -o eth0 -j MASQUERADE
ListenPort = 2000
 
[Peer]
PublicKey = 84j1v8jtdMXbA3Oi6Gz4AR+uQ2hfDCYypQ0PSFwRAkk=
Endpoint = 218.2.xx.xx:2000 # 指定要访问的服务端网段,或者设置0.0.0.0/0来进行全局代理.
AllowedIPs = 192.168.100.0/24,192.168.0.0/22,10.244.0.0/16,192.168.5.0/24 
PersistentKeepalive = 25

```

参考

https://linux.cn/article-11916-1.html

https://opswill.com/articles/wireguard-howtos.html