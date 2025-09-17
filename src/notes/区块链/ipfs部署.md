# IPFS 部署

#### 方式1：kubernetes部署（ipfs和ipfs分别使用sts部署）

ipfs

1、初始化

ipfs init

2、写入配置

ipfs config Addresses.API /ip4/0.0.0.0/tcp/5001

ipfs config Addresses.Gateway /ip4/0.0.0.0/tcp/8080

ipfs config --json Swarm.ConnMgr.HighWater 2000

ipfs config --json Datastore.BloomFilterSize 1048576

ipfs config Datastore.StorageMax 100GB

3、删除所有公网节点

ipfs  bootstrap rm all

4、添加节点

ipfs bootstrap add  /dns/ipfs-0.ipfs/tcp/4001/p2p/12D3KooWCER4oWMq1iQiiD5ojJPp4janqPpCGQv9vU4Fma2WKe6M

ipfs bootstrap add  /dns/ipfs-1.ipfs/tcp/4001/p2p/12D3KooWNFdvTGd2ayjsZWjfyw5bLWBSkBLaZ2M7mxyp4bgcbnvG

ipfs bootstrap add  /dns/ipfs-2.ipfs/tcp/4001/p2p/12D3KooWBUSXy2Q3deRqLdCSxwy4jE2V9x3djdedqqmRfnHxpmA1

\---

ipfs bootstrap add  /ip4/172.31.255.109/tcp/4001/p2p/12D3KooWCER4oWMq1iQiiD5ojJPp4janqPpCGQv9vU4Fma2WKe6M

ipfs bootstrap add  /ip4/172.31.255.218/tcp/4001/p2p/12D3KooWNFdvTGd2ayjsZWjfyw5bLWBSkBLaZ2M7mxyp4bgcbnvG

ipfs bootstrap add  /ip4/172.31.255.92/tcp/4001/p2p/12D3KooWBUSXy2Q3deRqLdCSxwy4jE2V9x3djdedqqmRfnHxpmA1

\---

ipfs bootstrap add  /ip4/10.0.1.18/tcp/31716/p2p/12D3KooWCER4oWMq1iQiiD5ojJPp4janqPpCGQv9vU4Fma2WKe6M

ipfs bootstrap add  /ip4/10.0.1.18/tcp/31163/p2p/12D3KooWNFdvTGd2ayjsZWjfyw5bLWBSkBLaZ2M7mxyp4bgcbnvG

ipfs bootstrap add  /ip4/10.0.1.18/tcp/32409/p2p/12D3KooWBUSXy2Q3deRqLdCSxwy4jE2V9x3djdedqqmRfnHxpmA1

5、查看节点

ipfs  bootstrap  list

6、添加私钥

/data/ipfs/swarm.key

7、启动

ipfs daemon

8、验证网络

ipfs swarm peers

\---

ipfs-cluster

1、初始化

ipfs-cluster-service init

2、修改配置指定ipfs节点

3、修改配置统一secret

4、启动

ipfs-cluster-service daemon --bootstrap /ip4/xxx/tcp/9096/ipfs/xxxxx

5、验证

ipfs-cluster-ctl peers ls

#### 方式2：官网提供yaml部署

ipfs

1、删除所有公网节点

ipfs  bootstrap rm all

2、添加节点

ipfs bootstrap add  /ip4/172.31.255.183/tcp/4001/p2p/12D3KooWAmV68roqmgJSHzTsX9SMGMAWFXcHVdmZAD8kZcvWM6Gd

ipfs bootstrap add  /ip4/172.31.255.172/tcp/4001/p2p/12D3KooWJFAqNFUAjKWAX8kuWS4yrvwQPGGiAHkq2Zi74M6DdZde

ipfs bootstrap add  /ip4/172.31.255.56/tcp/4001/p2p/12D3KooWGLcdprWgBhr5LJ8sFVx1GY2kXGoF33wNWDywPyhak4To

\---

ipfs bootstrap add  /dns/ipfs-cluster-0-np/tcp/4001/p2p/12D3KooWAmV68roqmgJSHzTsX9SMGMAWFXcHVdmZAD8kZcvWM6Gd

ipfs bootstrap add  /dns/ipfs-cluster-1-np/tcp/4001/p2p/12D3KooWJFAqNFUAjKWAX8kuWS4yrvwQPGGiAHkq2Zi74M6DdZde

ipfs bootstrap add  /dns/ipfs-cluster-2-np/tcp/4001/p2p/12D3KooWGLcdprWgBhr5LJ8sFVx1GY2kXGoF33wNWDywPyhak4To

\---

ipfs bootstrap add  /ip4/10.0.1.18/tcp/32455/p2p/12D3KooWAmV68roqmgJSHzTsX9SMGMAWFXcHVdmZAD8kZcvWM6Gd

ipfs bootstrap add  /ip4/10.0.1.18/tcp/30245/p2p/12D3KooWJFAqNFUAjKWAX8kuWS4yrvwQPGGiAHkq2Zi74M6DdZde

ipfs bootstrap add  /ip4/10.0.1.18/tcp/32285/p2p/12D3KooWGLcdprWgBhr5LJ8sFVx1GY2kXGoF33wNWDywPyhak4To

3、查看节点

ipfs  bootstrap  list

4、添加私钥

/data/ipfs/swarm.key

5、重启

6、验证

ipfs swarm peers

\---

ipfs-cluster

1、验证

ipfs-cluster-ctl peers ls

#### 方式3：容器方式启动ipfs节点并加入私有ipfs网络

1、启动容器

docker run -itd --entrypoint sh --name ipfs4 ipfs/go-ipfs:v0.9.0

2、初始化ipfs

ipfs init  

12D3KooWRN4BJohV53CqYdLy9prQ7en4tkft7dajWrkf2evE6rHm

3、写入配置

ipfs config Addresses.API /ip4/0.0.0.0/tcp/5001

ipfs config Addresses.Gateway /ip4/0.0.0.0/tcp/8080

ipfs config --json Swarm.ConnMgr.HighWater 2000

ipfs config --json Datastore.BloomFilterSize 1048576

4、添加key

swarm.key 至/data/ipfs/文件夹下

5、删除公网节点连接

ipfs bootstrap rm all

6、添加私有节点ipfs3

ipfs bootstrap add  /ip4/172.17.0.4/tcp/4001/p2p/12D3KooWRN4BJohV53CqYdLy9prQ7en4tkft7dajWrkf2evE6rHm

7、启动

ipfs daemon

总结：

1、ipfs多个节点可以组成一个私有ipfs网络；

2、多个ipfs节点私有ipfs网络则需要一个共同的key文件，放置到/data/ipfs/文件夹下；

3、ipfs-cluster：是用来管理多个ipfs节点的工具，这个地方需要注意：

​	a、一个ipfs-cluster-service服务对应一个ipfs节点，是在ipfs-cluster-service的service.json文件里指定的

​	b、多个ipfs-cluster-service服务组成集群需要在service.json里指定共同的secret；

​	c、ipfs-cluster-service服务通过--bootstrap 指定某个ipfs-cluster-service进行连接，组成一个ipfs-cluster，有点类似ipfs网络；

​	d、这个集群是分布式的，里面的节点没有什么主从之分；

​	e、ipfs-cluster-ctl作为客户端连接ipfs-cluster-servic来管理这个集群下的多个节点；

其他：

1、生成随机 secret 的命令

od  -vN 32 -An -tx1 /dev/urandom | tr -d ' \n' | base64 -w 0 -

2、手动生成ipfs-cluster-service的id和私钥

https://github.com/whyrusleeping/ipfs-key

参考&工具

https://cluster.ipfs.io/

https://github.com/whyrusleeping/ipfs-key#installation

https://docs.ipfs.io/

https://github.com/ipfs

https://gguoss.github.io/2017/05/28/ipfs/

https://www.zhihu.com/people/flytofuture/posts

