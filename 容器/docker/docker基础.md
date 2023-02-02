### 1、容器技术原理


 LXC:LinuX Container

 主机级虚拟化：VMware station
  Type-I:硬件-->虚拟机管理器-->虚拟机
  Type-II:硬件-->HostOS-->虚拟机管理器-->虚拟机

 利用6种namespace(名称空间)和cgroup进行资源隔离

 Linux Namespaces:
 UTS,IPC,PID,Network,Mount，User


 Control Groups（cgroups）


 主流的三种容器编排工具：

 machine+swarm+compose
 mesos+marathon
 kubemetes 

### 2、Docker 基础用法

#### 镜像

```
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

####   容器

```
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
docker export containerId >images.tar

导入
cat images.tar | docker import - images:tag

commit
docker commit  a404c6c174a2  mymysql:v1 

```

docker save 和docker export以及docker commit的区别
1. docker save保存的是镜像（image），docker export保存的是容器（container）
2. docker load用来载入镜像包，docker import用来载入容器包，但两者都会恢复为镜像
3. docker load不能对载入的镜像重命名，而docker import可以为镜像指定新名称
4. docker save 没有丢失镜像的历史，可以回滚到之前的层（layer）.docker export 会丢失镜像的历史（变成了1层）,回滚方法：(docker tag <LAYER ID> <IMAGE NMME>)
5. docker commit 就是将container当前的读写层保存下来，保存成一个新层,加上只读层做成一个新镜像（比之前的镜像多了一层）

#### 其他

```
获取容器/镜像的元数据
docker inspect container|image

查看容器资源使用状态
docker stats 


```







### 3、docker 安装

centos

```
sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine
                  
#
sudo yum install -y yum-utils
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
    
#
sudo yum install docker-ce docker-ce-cli containerd.io docker-compose-plugin

#
yum list docker-ce --showduplicates | sort -r

#
sudo yum install docker-ce-18.06.0.ce-3.el7 docker-ce-cli-18.06.0.ce-3.el7 containerd.io docker-compose-plugin
```

参考

https://docs.docker.com/engine/install/







3、Docker镜像相关


 镜像原理理解：
  名词解析：
    bootfs:boot file system :引导文件系统，包括bootloader和kernel，当bootloader引导kernel加载到内存后，系统会卸载bootfs，以节省资源；
    rootfs:root file system ：root文件系统（根文件系统）
    aufs:advanced union file system（高级联合文件系统）


  docker文件系统简述：
   最底层为bootfs,然后是rootfs;
    所有 Docker 容器都共享主机系统的 bootfs 即 Linux 内核;
    每个容器有自己的 rootfs，它来自不同的 Linux 发行版的基础镜像，包括 Ubuntu，Debian 和 SUSE 等，其中ubuntu:aufs；centos7:devicemapper。
    所有基于一种基础镜像的容器都共享这种rootfs;

   Docker 目前支持的文件系统包括 AUFS, btrfs, vfs 和 DeviceMapper；

  那么docker的rootfs与传统意义的rootfs不同之处到底是什么呢？


   传统的Linux加载bootfs时会先将rootfs设为read-only，然后在系统自检之后将rootfs从read-only改为read-write。然后我们就可以在rootfs上进行写和读的操作了。
   而docker镜像在bootfs自检完毕之后并不会把rootfs的read-only改为read-write。而是利用union mount（UnionFS的一种挂载机制）将一个或多个read-only的rootfs加载到之前的read-only 的rootfs层之上。
   并在加载了这么多层的rootfs之后，仍然让它看起来只像一个文件系统，在docker的体系里把union mount的这些read-only层的rootfs叫做docker的镜像（image）。此时的每一层rootfs都是read-only的，那么我们怎样对其进行读写操作呢？


   答案是将docker镜像进行实例化，也就是把镜像（image）变成容器（container），当镜像被实例化为容器之后，系统会为在一层或是多层的read-only的rootfs之上分配一层空的read-write的rootfs。而这个分配的动作是由docker run命令发起的；


   当我们将一个镜像实例化为一个容器之后，docker会在read-only 的rootfs之上分配一层空的read-write的rootfs，我们对文件系统的改变实际上是在空的这层rootfs（read-write）上发生的。
   如果你想修改一个文件，系统实际上是将这个在read-only层的rootfs的文件拷贝到read-write层的rootfs之中，然后对它进行修改，但read-only层的文件并不会被修改，依然存在于read-only层之中，只不过是在read-write层下被隐藏了。
   这种模式被称为copy on write。这是unionFS的特性。也是docker的强大之处，为什么说强大呢？它允许镜像被继承，也就是说我们想生成一套虚拟环境不用从零开始了，而只要在一个相对完善的基础环境之上来创建我们的虚拟环境就可以了，比如我们想生成一个具有tomcat环境的镜像，只要在一个装有java环境的镜像之上来创建就可以了。这也是docker便捷性的体现。

 镜像仓库相关：

  docker registry:？
   Sponsor Registry:
   Mirror Registry:
   Vendor Registry:
   Private Registry:私有仓库：通过设有防火墙和额外的安全层的私有实体提供的registry


  Registry（repository and index）:注册服务器
  Repository:仓库
  Registry是存放仓库的地方，一个Registry中可以存在多个repository，每个仓库集中存放某一类镜像，往往包括多个镜像文件，通过不同的标签（tag）来进行区分（每个标签对应一个镜像）；


 镜像制作：

  基于容器制作：
   在容器完成操作后制作；
    docker commit
     --author, -a
     --pause,-p
     --message,-m
     --change,-c
     
    docker commit -p b2；
    docker commit container image-name；

  基于镜像制作：
   编辑dockerfile 
   Dockerfile Instructions（dockerfile说明）:



4、docker容器网络？


 两级三层封装：容器之间的ip通过物理主机之间的ip再封装一次，实现容器之间的通信；


 docker network ls


 yum install bridge-utils


 brctl show

 ip link show


 网卡一半在容器里，一半在宿主机的网桥上


 iptables -t nat -vnL


 外部服务器如何访问容器web?
  暴露服务：开放物理主机端口，利用dnet转到容器 

 每个容器都有独立的6种名称空间：UTS，User,Mount,IPC,Pid,Net
 但可以共享：UTS,Net，IPC 
 容器也可以和物理机共享名称空间




 4种容器网络模型：


 closed  container   lo(封闭式容器) 


 bridges  container (net网络，桥接网络)


 Joined container  (联盟式网络-容器之间共享网络名称空间)


 Open container(开放式网络-容器和物理机之间的共享网络名称空间（网络接口）)




 docker network inspect bridge#查看docker network 详细元数据信息

  


 ip netns 命令


 ip netns list


 ip link add name veth1.1 type veth peer name veth1.2


 ip netns exec r1 ifconfig  -a 


 将网卡分配到网络名称空间


 ip netns exec r2 ifconfig veth1.1 10.1.0.3/24 up 


 ip netns exec r1 ping 10.1.0.2


 docker run --name tt1 -it -h mage --network bridge --dns 114.114.114.114 --dns-search ilinux.io --add-host docker.com:172.0.0.3 --rm busybox:latest


 nslookup -type=A www.baidu.com


 Opening inbound communication


 -p containterPort 将指定的容器端口映射至主机所有地址的一个动态端口


  hostPort:containerPort 将容器端口映射至指定的主机端口

  ip::containerPort将指定的容器端口映射至主机指定的ip 的端口

  ip:hostPort:containerPort将指定的容器端口映射至主机指定的ip的端口 

  _P或--pushlish-all 将容器的所有计划要暴露端口全部映射至主机端口

  docker run -d -P --expose2222 --expose 3333 --name web busybox /bin/httpd -p 2222 -f

 docker run --name myweb --rm -p 80 httpd:v.02


 docker run --name myweb --rm -p 172.20.0.1:：80 httpd:v0.2


 docker port myweb


 Joined container


 docker run --name bb2 --network container:bb1 -it --rm busybox


 docker run --nbb2 --network host -it --rm busybox



 docker守护进程C/S，其默认仅监听Unix Socket格式的地址，/var/run/docker.sock;如果使用TCP套接字，


 /etc/docker/daemon.json：


"hosts":["tcp://0.0.0.0:2375","unix:///var/run/docker.sock"]


 也可以直接 docker -H 


 自定义docker桥的网卡属性：/etc/docker/daemon.json文件




5、Docker存储卷


 volume：存储卷


 主机和容器路径的映射关系 
 /data/web ->/containers/data/web


 服务分类：
 有状态需要持久存储
 有状态无需要持久存储
 无状态需要持久存储
 无状态无需要持久存储


 2种挂载方式


 1、docker run --name test1 -it -v /data busybox


 docker inspect -f {{.NetworkSettings.xxxx}} 4dbeeedc95cd


 2、docker run -it --name test2 --rm -v /data/volume/test2:/data/test2 busybox


 主机：/data/volume/test2
 容器：/data/test2


 joined Containers？

 多个容器的卷使用同一个目录：
  docker run -it --name box1 -v /docker/volumes/v1:/data busybox


  docker run -it --name box2 -v /docker/volumes/v1:/data busybox


 复制其他容器的卷：


  docker run -it --name box1 -v /docker/volumes/v1:/data busybox


  docker run -it --name box2 --volumes-from box1 busybox



6、Docker私有registry


 包名：docker-distribution

 查看信息：docker info docker-registry

 安装：yum install docker-registry

 配置文件：/etc/docker-distribution/registry/config.yml


  docker tag busybox:latest Ali-byg:5000/busybox:latest#打标签

  docker push Ali-byg:5000/busybox:latest#上传

 注意：docker-registry 默认使用http协议，而push默认使用https协议

 解决办法：a.把docker-registry改为https
     b.将docker 设置为非保密模式，
     vim /etc/docker/daemon.json
      添加  "insecure-registries": ["Ali-byg:5000"]


     重启docker systemctl restart docker.service

  通常用方法b  




 搭建 vmware harbor 企业级容器仓库

  vmware harbor使用的http协议
  前提：
   yum install docker
   yum install docker-compose

  下载包：
   wget  https://storage.googleapis.com/harbor-releases/harbor-offline-installer-v1.5.2.tgz 
  解压：
   tar -xf harbor-offline-installer-v1.5.2.tgz -C /usr/local/
  配置：
   cd /usr/local/harbor;vim harbor.cfg
   hostname = ip#一定是外网IP
  运行：
   ./install.sh
  访问：
   http://ip:80
  账号信息： 
   admin/Harbor12345  

  重启docker：
   systemctl daemon-reload
   systemctl restart docker

  启动停止harbor

  docker-compose stop|start

  docker-compose ？？之间的关系

7、Docker的系统资源限制及验正


 三种资源：memory,CPU，I/O


 memory：非可压缩性资源

  OOME：Out Of Memory Exception 
  调整dockers daemon 或重要容器的oom优先级 
  -m OR --memory= M   #定义限制RAM  
  --memory-swap=S 容器可用总空间为S  

 CPU：可压缩性资源
  根据需求分享

 docker pull lorel/docker-stress-ng:latest #下载压测镜像


 docker states #查看容器资源利用


  docker run --name stress -it --cpu-share 1024 --rm lorel/docker-stress-ng:latest stress --cpu 8 


 容器安全方面 

