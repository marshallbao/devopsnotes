### iptables

### 定义

iptables 是 Linux 上一个强大的防火墙工具，用于管理网络包的过滤、转发和地址转换。它工作在用户空间，利

用内核中的 netfilter 框架来实现其功能。iptables 可以根据源地址、目的地址、传输协议、应用程序端口等信

息，对进出网络接口的数据包进行精细控制。

### 功能

网络地址转换(Network Address Translate)

数据包内容修改

以及数据包过滤的防火墙功能

#### iptables、Ufw（Uncomplicated Firewall）、firewalld 和 nftables的区别和联系

##### 各自定义

iptables、Ufw（Uncomplicated Firewall）、firewalld 和 nftables 是 Linux 上用于管理和配置网络流量规则的不同工具和框架。它们在功能上有所重叠，但也有各自的特点和使用场景。

**iptables**
iptables 是长期以来 Linux 系统中用于配置防火墙规则的标准工具。它操作复杂但功能强大，直接操作内核的 

netfilter 框架来控制进出数据包。

特点：功能全面，灵活性高，但配置相对复杂，学习曲线陡峭。

**Ufw（Uncomplicated Firewall）**

Ufw 是为了简化 iptables 的配置而设计的接口，提供了一个更用户友好的方式来管理防火墙规则。

特点：易于使用，适合那些希望通过简单命令配置防火墙而不需要深入了解所有细节的用户。

**firewalld**

firewalld 是一个较新的防火墙管理工具，旨在提供动态的防火墙管理功能，不需要重启服务即可应用新的规则。

特点：支持区域和服务的概念，可以更灵活地组织规则，适合动态和复杂的网络环境。它也可以使用 iptables 或 

nftables 作为后端。

**nftables**

nftables 是 iptables 的后继者，旨在解决 iptables 的一些设计问题，提供更高效和更直观的方式来管理网络相关

的钩子。

特点：提供了一种新的语法和工具集，用于配置内核的 packet filtering 规则。它整合了之前 iptables、

ip6tables、arptables 和 ebtables 的功能。

##### 关系

iptables 和 nftables 都是直接与 Linux 内核的 netfilter 框架交互。

Ufw 是 iptables 的前端工具，旨在简化其配置过程。

firewalld 可以使用 iptables 或 nftables 作为其后端，提供动态防火墙管理。

### 基本概念

表（Table）：iptables 中的表是一组规则链的集合，用于存储特定类型的规则。常见的表有

filter 表：负责过滤功能，防火墙；内核模块：iptables_filter

nat 表：network address translation，网络地址转换功能；内核模块：iptable_nat

mangle 表：拆解报文，做出修改，并重新封装 的功能；iptable_mangle

raw 表：关闭nat表上启用的连接追踪机制；iptable_raw



链（Chain）：链是一组按顺序排列的规则，用于对数据包进行处理。常见的链有INPUT、OUTPUT、FORWARD、PREROUTING 和 POSTROUTING。



| 链名           | 功能                         |
| -------------- | ---------------------------- |
| **INPUT**      | **处理输入数据包**           |
| **OUTPUT**     | **处理输出数据包**           |
| **PORWARD**    | **处理转发数据包**           |
| **PREROUTING** | **用于目标地址转换（DNAT）** |
| **POSTOUTING** | **用于源地址转换（SNAT）**   |

规则（Rule）：规则是 iptables 中的基本单位，用于定义如何处理数据包。规则包括匹配条件和目标动作，当数据包满足匹配条件时，将执行目标动作。



##### 终止目标

| 动作       | 含义                                                         |
| ---------- | ------------------------------------------------------------ |
| ACCEPT     | 允许数据包通过                                               |
| DROP       | 直接丢弃数据包，不给任何回应信息，这时候客户端会感觉自己的请求没有响应，过了超时时间才会有反应。 |
| REJECT     | 拒绝数据包通过，必要时会给数据发送端一个响应的信息，客户端刚请求就会收到拒绝的信息 |
| SNAT       | 源地址转换，解决内网用户用同一个公网地址上网的问题           |
| MASQUERADE | 是SNAT的一种特殊形式，适用于动态的、临时会变的ip上           |
| DNAT       | 目标地址转换                                                 |
| REDIRECT   | 在本机做端口映射                                             |
| LOG        | 在/var/log/messages文件中记录日志信息（其实就是写入系统日志，通过dmesg也可以看到），然后将数据包传递给下一条规则，也就是说除了记录以外不对数据包做任何其他操作，仍然让下一条规则去匹配 |



|          |            | 链表关系 |         |        |             |
| -------- | ---------- | -------- | ------- | ------ | ----------- |
| Tables   | PREROUTING | INPUT    | FORWARD | OUTPUT | POSTROUTING |
| raw      | ✅          |          |         | ✅      |             |
| mangle   | ✅          | ✅        | ✅       | ✅      | ✅           |
| nat      | ✅          |          |         | ✅      | ✅           |
| filter   |            | ✅        | ✅       | ✅      |             |
| security |            | ✅        | ✅       | ✅      |             |

##### 其他

1. 防火墙策略规则的匹配顺序是从上至下的，因此要把较为严格、优先级较高的策略规则放到前面

2. 表的优先级为： raw -> mangle -> nat -> filter
3. 最常用的就是 filter、nat 表
4. 数据包经过一条链要将所有的规则都匹配一遍



##### 数据包处理流程图

![image-20240411152150502](iptables.assets/image-20240411152150502.png)

### 常用参数

```
参数	作用
-t  指定表，不指定默认为 filter 表
-P	设置默认策略
-F	清空规则链
-Z  清空规则链中的数据包计算器和字节计数器
-X  删除自定义链
-L	查看规则链
-A	在规则链的末尾加入新规则
-I num	在规则链的头部加入新规则
-D num	删除某一条规则
-s	匹配来源地址IP/MASK，加叹号“!”表示除这个IP外
-d	匹配目标地址
-i 网卡名称	匹配从这块网卡流入的数据
-o 网卡名称	匹配从这块网卡流出的数据
-p	匹配协议，如TCP、UDP、ICMP
--dport num	匹配目标端口号
--sport num	匹配来源端口号
--
-v 详细模式,显示规则时提供更多的信息
-n 数值模式,在输出结果时使用数字地址（IP 地址和端口号），而不是尝试将它们解析为主机名、网络名或服务名
--line-numbers 规则展示序号
```

### 常用命令

```
# 查看 iptables 规则
iptables -vnL --line-numbers
iptables -t nat -vnL --line-numbers

# 添加 filter 表规则
iptables -A INPUT -p tcp --dport 179 -j ACCEPT
iptables -A INPUT -p 89 -j ACCEPT

# 添加 nat 表规则
iptables -t nat -A POSTROUTING -d 10.24.0.0/16 -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -d 10.5.0.0/25 -o eth0 -j MASQUERADE

# 修改 FORWARD 链的默认规则为 DROP
iptables -P FORWARD DROP
```





### 参考

https://typonotes.com/posts/2021/06/25/linux-iptable-introduce/

https://www.cnblogs.com/liufarui/p/10970468.html

https://zhuanlan.zhihu.com/p/618848653