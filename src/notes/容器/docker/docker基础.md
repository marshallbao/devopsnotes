# docker 基础

### 容器技术原理

 LXC:LinuX Container

 主机级虚拟化：VMware station
  Type-I:硬件--> 虚拟机管理器-->虚拟机
  Type-II:硬件--> HostOS -->虚拟机管理器-->虚拟机

 利用6种namespace(名称空间)和cgroup进行资源隔离

 Linux Namespaces:
 UTS,IPC,PID,Network,Mount，User

 Control Groups（cgroups）

 主流的三种容器编排工具：

 machine+swarm+compose
 mesos+marathon
 kubemetes

### Docker 基础用法

#### 镜像

```shell
下载镜像
docker pull images-name:tag（不加版本号默认为latest）

上传镜像
docker push image

登陆镜像仓库
docker login -u -p

登出
docker logout

查看
docker images
 -q：只显示镜像ID
删除镜像
docker rmi images 

打包
docker save -o imgage.tar imgage

解压
docker load -i image.tar

tag
docker tag ubuntu:15.10 runoob/ubuntu:v3
```

#### 镜像 run 容器

```shell
docker run -it images

-i: 以交互模式运行容器，通常与 -t 同时使用；
-t: 为容器重新分配一个伪输入终端，通常与 -i 同时使用；
-p: 端口映射，格式为：主机(宿主)端口:容器端口
--name="test": 为容器指定一个名称；
-e username="ritchie": 设置环境变量；
-m :设置容器使用内存最大值；
--net="bridge": 指定容器的网络连接类型，支持 bridge/host/none/container: 四种类型；
--expose=[]: 开放一个端口或一组端口；
--rm:运行完后自动删除
```

#### 容器

```shell
查看
docker ps 
-a 查看所有容器

启动/停止/重启
docker start|stop|restart  container

暂停|恢复
docker pause|unpause container

杀死
docker kill container

删除
docker rm container
  -f :通过SIGKILL信号强制删除一个运行中的容器
  -v :删除与容器关联的卷
进入
docker exec -it container sh
docker attach container

日志
 docker logs  -f --tail 200 container

导出
docker export containerId > images.tar

导入
cat images.tar | docker import - images:tag

commit
docker commit  a404c6c174a2  mymysql:v1 

```

docker save 和 docker export 以及 docker commit 的区别

1. docker save 保存的是镜像（image），docker export保存的是容器（container）
2. docker load 用来载入镜像包，docker import用来载入容器包，但两者都会恢复为镜像
3. docker load 不能对载入的镜像重命名，而 docker import可 以为镜像指定新名称
4. docker save 没有丢失镜像的历史，可以回滚到之前的层（layer）.docker export 会丢失镜像的历史（变成了1层）,回滚方法：(docker tag \<ID\> \<IMAGE NMME\>)
5. docker commit 就是将 container 当前的读写层保存下来，保存成一个新层,加上只读层做成一个新镜像（比之前的镜像多了一层）

#### 其他

```shell
# 获取容器/镜像的元数据
docker inspect container/image

# 查看容器资源使用状态
docker stats
```

### Docker 镜像相关

#### 镜像原理理解

**名词解析**
bootfs：boot file system ，引导文件系统，包括 bootloader 和 kernel，当 bootloader 引导kernel加载到内存

后，系统会卸载bootfs，以节省资源；

rootfs：root file system ，root 文件系统（根文件系统）

aufs：advanced union file system（高级联合文件系统）

**docker 文件系统简述**
Docker 目前支持的文件系统包括 AUFS, btrfs, vfs 和 DeviceMapper；

最底层为 bootfs,然后是 rootfs;

所有 Docker 容器都共享主机系统的 bootfs 即 Linux 内核;

每个容器有自己的 rootfs，它来自不同的 Linux 发行版的基础镜像，包括 Ubuntu，Debian 和 SUSE 等

所有基于一种基础镜像的容器都共享这种 rootfs;

那么docker的 rootfs 与传统意义的 rootfs 不同之处到底是什么呢 ？

传统的Linux加载bootfs时会先将rootfs设为read-only，然后在系统自检之后将rootfs从read-only改为read-

write。然后我们就可以在rootfs上进行写和读的操作了

而docker镜像在bootfs自检完毕之后并不会把rootfs的read-only改为read-write。而是利用union

mount（UnionFS的一种挂载机制）将一个或多个read-only的rootfs加载到之前的read-only 的rootfs层之上。

并在加载了这么多层的rootfs之后，仍然让它看起来只像一个文件系统，在docker的体系里把union mount的这些

read-only层的rootfs叫做docker的镜像（image）。此时的每一层rootfs都是read-only的，那么我们怎样对其进

行读写操作呢？

答案是将docker镜像进行实例化，也就是把镜像（image）变成容器（container），当镜像被实例化为容器之

后，系统会为在一层或是多层的read-only的rootfs之上分配一层空的read-write的rootfs。而这个分配的动作是由

docker run命令发起的；

当我们将一个镜像实例化为一个容器之后，docker 会在read-only 的rootfs之上分配一层空的read-write的

rootfs，我们对文件系统的改变实际上是在空的这层rootfs（read-write）上发生的。

如果你想修改一个文件，系统实际上是将这个在 read-only 层的 rootfs 的文件拷贝到 read-write 层的 rootfs 之

中，然后对它进行修改，但 read-only 层的文件并不会被修改，依然存在于read-only层之中，只不过是在read-

write 层下被隐藏了。

这种模式被称为 copy on write。这是 unionFS 的特性。

#### 镜像制作

基于容器制作

在容器完成操作后制作

```shell
docker commit
   --author, -a
   --pause,-p
   --message,-m
   --change,-c
docker commit -p b2
docker commit container image-name
```

基于镜像制作：

编辑 Dockerfile

#### vmware harbor 容器仓库

```shell
# vmware harbor 使用的http协议
# 安装 docker
yum install docker
yum install docker-compose

# 下载包
wget  https://storage.googleapis.com/harbor-releases/harbor-offline-installer-v1.5.2.tgz 

# 解压
tar -xf harbor-offline-installer-v1.5.2.tgz -C /usr/local/

# 配置
cd /usr/local/harbor; vim harbor.cfg
hostname = ip # 一定是外网IP

# 运行
./install.sh

# 访问
http://ip:80

# 账号信息
admin/Harbor12345  

# 启动停止 harbor
docker-compose stop|start
```

### docker 容器网络

两级三层封装：容器之间的 ip 通过物理主机之间的 ip 再封装一次，实现容器之间的通信

```shell
# 查看网络驱动
docker network ls
NETWORK ID     NAME      DRIVER    SCOPE
204f594eddeb   bridge    bridge    local
b46568b99ca2   host      host      local
4548aefba753   none      null      local

# 查看docker network 详细元数据信息
docker network inspect bridge#
```

示例

```shell
docker run --name tt1 -it -h mage --network bridge --dns 114.114.114.114 --dns-search ilinux.io --add-host docker.com:172.0.0.3 --rm busybox:latest
# 参数
-p containterPort 将指定的容器端口映射至主机所有地址的一个动态端口
hostPort:containerPort 将容器端口映射至指定的主机端口
ip::containerPort 将指定的容器端口映射至主机指定的ip 的端口
ip:hostPort:containerPort 将指定的容器端口映射至主机指定的ip的端口 
-P 或 --pushlish-all 将容器的所有计划要暴露端口全部映射至主机端口
```

docker 守护进程C/S，其默认仅监听 Unix Socket 格式的地址，/var/run/docker.sock; 如果使用 TCP 套接字，

/etc/docker/daemon.json：

"hosts":["tcp://0.0.0.0:2375","unix:///var/run/docker.sock"]

也可以直接 docker -H

自定义 docker 桥的网卡属性：/etc/docker/daemon.json 文件

### Docker存储卷

volume：存储卷

主机和容器路径的映射关系

/data/web  -> /containers/data/web

2 种挂载方式

1、docker run --name test1 -it -v /data busybox

2、docker run -it --name test2 --rm -v /data/volume/test2:/data/test2 busybox
主机：/data/volume/test2

容器：/data/test2

多个容器的卷使用同一个目录：

docker run -it --name box1 -v /docker/volumes/v1:/data busybox

docker run -it --name box2 -v /docker/volumes/v1:/data busybox

复制其他容器的卷：

docker run -it --name box1 -v /docker/volumes/v1:/data busybox

docker run -it --name box2 --volumes-from box1 busybox

### Docker 的系统资源限制及验正

三种资源：memory，CPU，I/O
