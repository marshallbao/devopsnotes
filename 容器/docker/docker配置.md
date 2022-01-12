​         配置docker api的三种方法：
​    1、修改/etc/docker/daemon.json文件，添加hosts（hosts 分tcp,uninx,fd三种模式）
​        "hosts": ["unix:///var/run/docker.sock", "tcp://0.0.0.0:40009"]
​    2、 修改/etc/sysconfig/docker
​        添加OPTIONS='-H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock'
​    3、修改/usr/lib/systemd/system/docker.servic，在参数ExecStart后添加
​        -H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock
​        
​        修改完后 systemctl daemon-reload，systemctl restart docker
​        然后ss -tnl查看端口有没有起来
​        
​       测试： curl http://ip:port/info 
​       
docker 配置TLS进行安全访问:
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