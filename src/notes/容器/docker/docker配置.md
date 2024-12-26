### 配置docker api的三种方法

1、修改/etc/docker/daemon.json文件，添加hosts（hosts 分tcp,uninx,fd三种模式）
​        "hosts": ["unix:///var/run/docker.sock", "tcp://0.0.0.0:40009"]

2、 修改/etc/sysconfig/docker
​        添加OPTIONS='-H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock'

3、修改/usr/lib/systemd/system/docker.servic，在参数ExecStart后添加 -H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock，修改完后 systemctl daemon-reload，systemctl restart docker

然后ss -tnl查看端口有没有起来测试： curl http://ip:port/info 

### docker 配置TLS进行安全访问

​    客户端：ca.pem，cert.pem,key,pem

​    服务端：ca.pem,server-cert.pem,server-key.pem

过程：
	1、客户端请求服务器,服务器返回server-cert.pem客户端通过ca.pem认证server-cert.pem的可信性，然后通过server-cert.pem 中的公钥加密数据发送给服务端；
	2、如果服务端需要对客户端进行验证，则客户端需要向服务器发送客户端的证书即cert.pem，服务器通过ca.pem验证其可信性，
	   然后通过cert.pem中的公钥加密数据发送给客户端，最后生成对话密码进行对话；
	
配置：
    1、 daemon.json添加

         "tlsverify": true, 
         "tlscacert": "/etc/docker/ca.pem", 
         "tlscert": "/etc/docker/server-cert.pem", 
         "tlskey": "/etc/docker/server-key.pem", 
         "hosts": ["tcp://192.168.80.128:2376","unix:///var/run/docker.sock"]
     
    2、访问
    docker -H=$HOST:2375   --tlsverify --tlscacert=ca.pem --tlscert=cert.pem --tlskey=key.pem 

docker拉取私服镜像需要登陆，docker login 之后会在~/.docker 下产生config.json文件，此文件即为认证文件；

### docker 配置文件 docker-daemon.json 详解

```
{
“api-cors-header”:"", ——————在引擎API中设置CORS标头
“authorization-plugins”:[], ——————要加载的授权插件
“bridge”:"", ————将容器附加到网桥
“cgroup-parent”:"", ——————为所有容器设置父cgroup
“cluster-store”:"", ——————分布式存储后端的URL
“cluster-store-opts”:{}, ————————设置集群存储选项（默认map []）
“cluster-advertise”:"", ————————要通告的地址或接口名称
“debug”: true, ————————启用调试模式，启用后，可以看到很多的启动信息。默认false
“default-gateway”:"", ——————容器默认网关IPv4地址
“default-gateway-v6”:"", ——————容器默认网关IPv6地址
“default-runtime”:“runc”, ————————容器的默认OCI运行时（默认为“ runc”）
“default-ulimits”:{}, ——————容器的默认ulimit（默认[]）
“dns”: [“192.168.1.1”], ——————设定容器DNS的地址，在容器的 /etc/resolv.conf文件中可查看。
“dns-opts”: [], ————————容器 /etc/resolv.conf 文件，其他设置
“dns-search”: [], ————————设定容器的搜索域，当设定搜索域为 .example.com 时，在搜索一个名为 host 的 主机时，DNS不仅搜索host，还会搜
索host.example.com 。 注意：如果不设置， Docker 会默认用主机上的 /etc/resolv.conf 来配置容器。
“exec-opts”: [], ————————运行时执行选项
“exec-root”:"", ————————执行状态文件的根目录（默认为’/var/run/docker‘）
“fixed-cidr”:"", ————————固定IP的IPv4子网
“fixed-cidr-v6”:"", ————————固定IP的IPv6子网
“data-root”:"/var/lib/docker", ————-Docker运行时使用的根路径，默认/var/lib/docker
“group”: “”, ——————UNIX套接字的组（默认为“docker”）
“hosts”: [], ——————设置容器hosts
“icc”: false, ——————启用容器间通信（默认为true）
“ip”:“0.0.0.0”, ————————绑定容器端口时的默认IP（默认0.0.0.0）
“iptables”: false, ———————启用iptables规则添加（默认为true）
“ipv6”: false, ——————启用IPv6网络
“ip-forward”: false, ————————默认true, 启用 net.ipv4.ip_forward ,进入容器后使用 sysctl -a | grepnet.ipv4.ip_forward 查看
“ip-masq”:false, ——————启用IP伪装（默认为true）
“labels”:[“nodeName=node-121”], ————————docker主机的标签，很实用的功能,例如定义：–label nodeName=host-121
“live-restore”: true, ——————在容器仍在运行时启用docker的实时还原
“log-driver”:"", ——————容器日志的默认驱动程序（默认为“ json-file”）
“log-level”:"", ——————设置日志记录级别（“调试”，“信息”，“警告”，“错误”，“致命”）（默认为“信息”）
“max-concurrent-downloads”:3, ——————设置每个请求的最大并发下载量（默认为3）
“max-concurrent-uploads”:5, ——————设置每次推送的最大同时上传数（默认为5）
“mtu”: 0, ——————设置容器网络MTU
“oom-score-adjust”:-500, ——————设置守护程序的oom_score_adj（默认值为-500）
“pidfile”: “”, ——————Docker守护进程的PID文件
“raw-logs”: false, ——————全时间戳机制
“selinux-enabled”: false, ——————默认 false，启用selinux支持
“storage-driver”:"", ——————要使用的存储驱动程序
“swarm-default-advertise-addr”:"", ——————设置默认地址或群集广告地址的接口
“tls”: true, ————————默认 false, 启动TLS认证开关
“tlscacert”: “”, ——————默认 ~/.docker/ca.pem，通过CA认证过的的certificate文件路径
“tlscert”: “”, ————————默认 ~/.docker/cert.pem ，TLS的certificate文件路径
“tlskey”: “”, ————————默认~/.docker/key.pem，TLS的key文件路径
“tlsverify”: true, ————————默认false，使用TLS并做后台进程与客户端通讯的验证
“userland-proxy”:false, ——————使用userland代理进行环回流量（默认为true）
“userns-remap”:"", ————————用户名称空间的用户/组设置
“bip”:“192.168.88.0/22”, ——————————指定网桥IP
“registry-mirrors”: [“https://192.498.89.232:89”], ————————设置镜像加速
“insecure-registries”: [“120.123.122.123:12312”], ———————设置私有仓库地址可以设为http
“storage-opts”: [
“overlay2.override_kernel_check=true”,
“overlay2.size=15G”
], ————————存储驱动程序选项
“log-opts”: {
“max-file”: “3”,
“max-size”: “10m”,
}, ————————容器默认日志驱动程序选项
“iptables”: false ————————启用iptables规则添加（默认为true）
}
```

