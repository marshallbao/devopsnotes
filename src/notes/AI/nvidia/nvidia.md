# GPU

### docker 环境使用 nvidia GPU，并搭建 CUDA 计算平台

##### 1、nvidia 驱动的安装
$lspci |grep -i nvidia  //查看显卡型号

登录 nvidia 官网，根据显卡型号下载显卡驱动

安装显卡驱动

##### 2、安装 docker（nvidia-docker）

直接配置 yum 源

yum install docker

##### 3、测试（docker 官网有 cuda 的镜像可以直接拉取使用）

docker run --runtime=nvidia --rm nvidia/cuda:9.0-base nvidia-smi //这里的runtime=nvidia可以直接在/etc/docker/daemon.json 配置文件中直接指定；

配置文件

```
cat > /etc/docker/daemon.json <<EOF
/etc/docker/daemon.json 
{
    "insecure-registries": ["0.0.0.0/0"],
    "hosts": ["unix:///var/run/docker.sock", "tcp://0.0.0.0:40008"],
    "graph": "/data/docker",
    "storage-driver": "overlay2",
    "storage-opts": [
            "overlay2.override_kernel_check=true"
    ],
    "default-runtime":"nvidia",
    "runtimes":{
            "nvidia":{
            "path":"nvidia-container-runtime",
            "runtimeArgas":{}
            }
    },
    "tlsverify": true,
    "tlscacert": "/etc/docker/.ssh/ca.pem",
    "tlscert": "/etc/docker/.ssh/server-cert.pem",
    "tlskey": "/etc/docker/.ssh/server-key.pem"
}
EOF
```

##### 4、搭建 cuda 平台



### 主机安装 cuda10.2

如果在主机上直接搭建 cuda 平台，可直接下载 cuda rpm 包，进行安装，因为 cuda 安装包内含 nvidia 驱动，可提前将机器上的 nvidia 驱动删除；

```
rpm -i cuda-repo-rhel7-10-2-local-10.2.89-440.33.01-1.0-1.x86_64.rpm
yum clean all
rpm -i vulkan-filesystem-1.1.73.0-1.el7.noarch.rpm
rpm -i dkms-2.3-5.8.noarch.rpm
yum install nvidia-driver-latest-dkms cuda
```

即安装完成，安装完成后要 reboot 节点，防止内核驱动和系统驱动不一致导致运行 nvidia-smi 命令错误；（也可能是之前遗留的驱动）


```
cat /proc/driver/nvidia/version   #查看驱动使用的内核版本

rpm -qa |grep nvidia  #查看刚安装的驱动

# 如遇到以下报错（也可以直接重启，也可以按照下面步骤操作）

$ nvidia-smi 
Failed to initialize NVML: Driver/library version mismatch

# 执行
$ rmmod nvidia
rmmod: ERROR: Module nvidia is in use by: nvidia_modeset

$ rmmod nvidia_modeset
rmmod: ERROR: Module nvidia_modeset is in use by: nvidia_drm

$ rmmod nvidia_drm
$ rmmod nvidia
$ nvidia-smi 
```



