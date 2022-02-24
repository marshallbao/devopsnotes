登录相关

登录认证过程：
主机认证，一次就可以了，就是第一次链接主机提示yes/no
用户认证，有公钥密码等多种认证方式；

公钥登录
客户端在家目录的 .ssh 目录下生成密钥对，将公钥发送至服务端用户的家目录的 .ssh 目录下，cat id_rsa.pub >>~/.ssh/authorized_keys

私钥登录
服务端生成密钥对，将私钥发送至客户端，cat id_rsa >> ~/.ssh/id_rsa(或者是重命名私钥文件为id_rsa-nyancat-gke，然后在客户端的ssh_config中声明IdentityFile ~/.ssh/id_rsa-nyancat-gke)

通过公钥或者私钥进行登录要根据实际环境进行考量（在sshd_config中将passwd认证设置为no）；