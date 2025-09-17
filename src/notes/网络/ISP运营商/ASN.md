# ASN

### AS

自治系统（Autonomous System, AS） 是指一组相互信任、使用相同路由策略的网络或子网，通过BGP（边界网关协议）进行通信

### ASN

自治系统编号（Autonomous System Number，ASN） 是一个唯一标识自治系统的32位整数，用于在BGP（边界网关协议）中标识不同的网络或网络提供商。在ESA的规则中，ASN被用作一种标识符，用于匹配和管理特定网络或地理区域的流量。

- 非洲网络信息中心（[AFRINIC](https://www.afrinic.net/)）。
- 美国互联网号码注册中心 ( [ARIN](https://www.arin.net/)）。
- 亚太网络信息中心（[APNIC](https://www.apnic.net/)）。
- 拉丁美洲和加勒比网络信息中心（[LACNIC](https://www.lacnic.net/)）。
- Réseaux IP Européens 网络协调中心 ( [RIPE NCC](https://www.ripe.net/) )。



命令

```
# 通过 ip 查看 ANS
whois -h whois.cymru.com " -v 47.245.8.99"
```

ASN 查找

https://dnschecker.org/asn-whois-lookup.php

IP 查找

https://iplocation.io/

亚太网络信息中心

https://www.apnic.net/



参考

https://help.aliyun.com/zh/edge-security-acceleration/esa/support/what-is-asn