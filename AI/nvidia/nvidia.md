## docker环境使用nvidiaGPU，并搭建CUDA计算平台

### 1、nvidia 驱动的安装
$lspci |grep -i nvidia  //查看显卡型号
登录nvidia官网，根据显卡型号下载显卡驱动
安装显卡驱动

2、安装 docker（nvidia-docker）
直接配置yum源
yum install docker即可；
Docker 19.03开始直接支持gpu,使用--gpus=x，选项即可使用gpu;
在19.03版本以下，需要安装nvidia-docker，来辅助docker支持gpu
配置yum源
yum search --showduplicates nvidia-docker 显示所有版本，查找你安装docker版本对应的nvidia-docker
3、测试（docker官网有cuda的镜像可以直接拉取使用）
docker run --runtime=nvidia --rm nvidia/cuda:9.0-base nvidia-smi //这里的runtime=nvidia可以直接在/etc/docker/daemon.json 配置文件中直接指定；

---

1、安装nvidia驱动
根据显卡型号，登陆官网下载相应驱动
nvidia-diag-driver-local-repo-rhel7-384.183-1.0-1.x86_64.rpm
rpm -i nvidia-diag-driver-local-repo-rhel7-384.183-1.0-1.x86_64.rpm
yum clean all 
yum install nvidia-driver

测试：nvidia-smi

2、安装 nvidia-docker2
根据 docker 版本 18.06.3，安装 nvidia-docker2
（测试版,以稳定版为主）
nvidia-docker2-2.4.0-1.docker18.06.3.ce.noarch.rpm
nvidia-container-runtime-3.3.0-1.docker18.06.3.x86_64.rpm
libnvidia-container1-1.2.0-1.x86_64.rpm
libnvidia-container-tools-1.2.0-1.x86_64.rpm
nvidia-container-toolkit-1.2.0-2.x86_64.rpm
（稳定版）
libnvidia-container1-1.1.1-1.x86_64.rpm
libnvidia-container-tools-1.1.1-1.x86_64.rpm	
nvidia-container-runtime-2.0.0-3.docker18.06.3.x86_64.rpm
nvidia-container-runtime-hook-1.4.0-1.x86_64.rpm
nvidia-docker2-2.0.3-3.docker18.06.3.ce.noarch.rpm

配置文件
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

3、搭建cuda平台



主机安装 cuda10.2
----------------------------------------------
如果在主机上直接搭建cuda平台，可直接下载cuda rpm包，进行安装，因为cuda安装包内含nvidia驱动，可提前将机器上的nvidia驱动删除；

#rpm -i cuda-repo-rhel7-10-2-local-10.2.89-440.33.01-1.0-1.x86_64.rpm
#yum clean all
#rpm -i vulkan-filesystem-1.1.73.0-1.el7.noarch.rpm
#rpm -i dkms-2.3-5.8.noarch.rpm
#yum install nvidia-driver-latest-dkms cuda

即安装完成，安装完成后要reboot节点，防止内核驱动和系统驱动不一致导致运行nvidia-smi命令错误；（也可能是之前遗留的驱动）
cat /proc/driver/nvidia/version   #查看驱动使用的内核版本（）
rpm -qa |grep nvidia  #查看刚安装的驱动

如遇到以下报错（也可以直接重启，也可以按照下面步骤操作）
#nvidia-smi 
Failed to initialize NVML: Driver/library version mismatch
执行
#rmmod nvidia
rmmod: ERROR: Module nvidia is in use by: nvidia_modeset
#rmmod nvidia_modeset
rmmod: ERROR: Module nvidia_modeset is in use by: nvidia_drm
#rmmod nvidia_drm
#rmmod nvidia
#nvidia-smi 
Wed Jul 22 00:40:14 2020       
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 440.33.01    Driver Version: 440.33.01    CUDA Version: 10.2     |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|===============================+======================+======================|
|   0  Tesla P100-PCIE...  Off  | 00000000:3B:00.0 Off |                    0 |
| N/A   34C    P0    33W / 250W |   2392MiB / 16280MiB |      0%      Default |
+-------------------------------+----------------------+----------------------+
|   1  Tesla P100-PCIE...  Off  | 00000000:AF:00.0 Off |                    0 |
| N/A   29C    P0    26W / 250W |     10MiB / 16280MiB |      0%      Default |
+-------------------------------+----------------------+----------------------+
                                                                               
+-----------------------------------------------------------------------------+
| Processes:                                                       GPU Memory |
|  GPU       PID   Type   Process name                             Usage      |
|=============================================================================|
|    0     94747      C   /usr/local/bin/python3                      1191MiB |
|    0     94748      C   /usr/local/bin/python3                      1191MiB |
+-----------------------------------------------------------------------------+   



--------------------------------------------------------------------------------
包信息
cuda9.0容器环境
显卡驱动：10.186.51.234:/applog/bao/nvidia/nvidia-diag-driver-local-repo-rhel7-384.183-1.0-1.x86_64.rpm
nvidia-docker:10.186.51.234:/applog/bao/nvidia/nvidia-docker2/*
cuda9.0镜像：目前镜像找不到了，可以去官网上拉取（官网地址：http://hub.docker.com/），在此镜像的基础上要安装
yum -y install unzip gcc make zlib-devel openssl openssl-devel libaio gcc-c++ bzip2-devel ncurses-devel sqlite-devel readline-develtk-devel gdbm-devel db4-devel libpcap-devel xz-devel perl
编译安装python3.6.7
还要在此基础上安装python关于cuda的库（研发操作）
cuda9.0rpm包：
10.186.51.234:/applog/bao/cuda9.0/cuda-repo-rhel7-9-0-local-9.0.176-1.x86_64.rpm
10.186.51.234:/applog/bao/cuda9.0/dkms-2.3-5.8.noarch.rpm

cuda10.2主机环境
cuda10.2rpm包：	
10.186.51.234:/applog/bao/cuda10.2/cuda-repo-rhel7-10-2-local-10.2.89-440.33.01-1.0-1.x86_64.rpm
10.186.51.234:/applog/bao/cuda10.2/dkms-2.3-5.8.noarch.rpm
10.186.51.234:/applog/bao/cuda10.2/vulkan-filesystem-1.1.73.0-1.el7_.noarch.rpm_.zip



【cuda镜像定制】
python3.6.7为基础镜像
rpm -i cuda-repo-rhel7-9-0-local-9.0.176-1.x86_64.rpm dkms-2.3-5.8.noarch.rpm
yum install cuda
**配置环境变量**
	--env "PATH=/usr/local/nvidia/bin:/usr/local/cuda-9.0/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin" \
    --env "LIBRARY_PATH=/usr/local/cuda-9.0/lib64/stubs" \
    --env "LD_LIBRARY_PATH=/usr/local/nvidia/lib:/usr/local/nvidia/lib64" \
    --env "CUDA_VERSION=9.0.176" \
    --env "NVIDIA_VISIBLE_DEVICES=all" \
	--env "CUDA_PKG_VERSION=9-0-9.0.176-1" \
	--env "NVIDIA_DRIVER_CAPABILITIES=compute,utility" \
	--env "NVIDIA_REQUIRE_CUDA=cuda&gt;=9.0" \
	

	cuda的安装目录是/usr/local/cuda-9.0
	基础镜像+python+cuda+PyTorch或者tensorflow依赖包

【测试】
python3
import torch
torch.cuda.is_available()	
返回是否是true
	
	
【故障排查】
	1、dkms install
	2、lsmod 重新加载