#### 制作 qcow2 镜像

下载 ISO 镜像

```
wget https://mirrors.tuna.tsinghua.edu.cn/ubuntu-releases/22.10/ubuntu-22.10-live-server-amd64.iso --no-check-certificate
```

创建空镜像

```
qemu-img create -f qcow2 /opt/kvm/ubuntu-18-base.qcow2 20G
```

根据 iso 镜像安装虚拟机

```
# 需要 XManager
virt-install --virt-type kvm --name ubuntu-18-base --vcpus 4 --ram 8192  --disk path=/opt/kvm/ubuntu-18-base.qcow2,format=qcow2,bus=virtio,size=30 --network bridge=br0,model=virtio --os-variant ubuntu18.04 --boot hd,network --graphics vnc,listen=0.0.0.0 --cdrom=/opt/bak/share/images/ubuntu-18.04.6-live-server-amd64.iso  --deug

# 需要输入账号密码等信息
```

配置 ip/dns/源 等其他内容

关机并清理

```
virsh shutdown ubuntu-20-base
virt-sysprep -d ubuntu-20-base
```

压缩镜像

```
virt-sparsify --compress ubuntu-20-base.qcow2 ubuntu-20-base-compress.qcow2
```

这时镜像就可以启动对应的虚拟机了