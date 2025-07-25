# Yum

yum（全称为 Yellow dog Updater, Modified）是一个在Fedora和RedHat以及SUSE中的Shell前端软件包管理器。基於RPM包管理，能够从指定的服务器自动下载RPM包并且安装，
可以自动处理依赖性关系，并且一次安装所有依赖的软体包，无须繁琐地一次次下载、安装.



### 使用



安装：
yum install nvidia-docker2
yum install --downloadonly --downloaddir=/tmp/ nvidia-docker2-2.0.3-3.docker18.06.3.ce.noarch 只下载不安装
yum localinstall package   安装本地包 


更新和升级
yum update 全部更新（升级所有包同时也升级软件和系统内核）！！！慎重！！
yum update package1 更新包
yum check-update 检查更新
yum upgrade package1 
yum groupupdate group1 （升级后，只升级所有包，不升级软件和系统内核）


查找和显示
yum info nvidia-info
yum info updates #列出可更新包的信息
yum info installed #列出已经安装包的信息
yum list #列出所有包（包括已安装和未安装）
yum list installed #列出已经安装得包
yum list updates #列出可更新的包
yum list extras  #列出所有已安装但不在yum Repository中的程序包。
yum list --showduplicates  docker-ce (列出一个包的所有版本)
\# 安装需要的指定版本包 yum -y install [服务名]-[版本号]  #注意服务名和版本号之间的 “ - ” 不是下划线

yum search --showduplicates nvidia-docker 查找包（显示所有版本)
yum search xxx  查找指定程序包，xxx可以是包名的一部分，会列出所有包含xxx的包名

卸载
yum remove package 卸载包
yum groupremove  grouppackage 删除整个包组
yum deplist package 查看包的依赖关系

yum clean all 清理缓存目录下的软件包
yum provides #列出软件包提供哪些软件