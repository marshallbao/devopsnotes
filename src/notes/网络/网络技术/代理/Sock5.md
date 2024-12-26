### 概念

SOCKS5（Socket Secure 5）是一个网络传输协议，用于在客户端和服务器之间进行数据通信，与 SOCKS4 相比，SOCKS5 提供更高级的安全和验证机制，同时可以协商最适合连接的通信协议（例如 TCP 或 UDP）。SOCKS5 被广泛应用于代理服务器，它可以允许客户端通过代理服务器访问 Internet。它支持各种身份验证方法，包括用户名和密码、GSS API 和 Kerberos V5 等

### 安装配置

1、安装socks5 依赖包

```
yum -y install gcc automake make pam-devel openldap-devel cyrus-sasl-devel
```

2、下载 ss5

```
# 官网
http://ss5.sourceforge.net/
# 包
wget https://udomain.dl.sourceforge.net/project/ss5/ss5/3.8.9-8/ss5-3.8.9-8.tar.gz
```

3、解压编译安装

```
tar -xf  ss5-3.8.9-8.tar.gz
cd ss5-3.8.9/
./configure && make && make install
```

4、配置

```
# 配置目录/文件
/etc/opt/ss5/
ss5.conf # 配置文件
ss5.ha #高可用配置文件
ss5.passwd # 用户认证文件

# 修改配置文件 ss5.conf,使其不需要账号密码就可以访问
auth    0.0.0.0/0               -               -
permit -        0.0.0.0/0       -       0.0.0.0/0       -       -       -       -       -

# 配置使用账号密码访问
auth    0.0.0.0/0               -               u

# 配置端口，修改配置文件 /etc/sysconfig/ss5
SS5_OPTS=" -u root -b 0.0.0.0:31003"

```

5、启动

```
service ss5 start
service ss5 stop
```

