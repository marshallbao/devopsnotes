### 私钥生成

RSA：RSA加密算法是一种非对称加密算法

DSA：Digital Signature Algorithm (DSA)是Schnorr和ElGamal签名算法的变种

#### ssh-keygen

```
ssh-keygen -t rsa -C "yonggui" -f ~/.ssh/test/crm-git
 
-t 表示密钥的类型 ，默认为 RSA
-b 表示密钥的长度，默认为 2048
-f 表示密钥文件的名字,默认为 /root/.ssh/id_rsa
-C 用于识别这个密钥的注释 
```



### 私钥登录

登录认证过程：
主机认证，一次就可以了，就是第一次链接主机提示 yes/no
用户认证，有公钥密码等多种认证方式；

公钥登录
客户端在家目录的 .ssh 目录下生成密钥对，将公钥发送至服务端用户的家目录的 .ssh 目录下，cat id_rsa.pub >>~/.ssh/authorized_keys

私钥登录
服务端生成密钥对，将私钥发送至客户端，cat id_rsa >> ~/.ssh/id_rsa(或者是重命名私钥文件为id_rsa-nyancat-gke，然后在客户端的ssh_config中声明IdentityFile ~/.ssh/id_rsa-nyancat-gke)

通过公钥或者私钥进行登录要根据实际环境进行考量（在sshd_config中将passwd认证设置为no）；







### SSH 转发

1、本地端口转发

2、远程端口转发

3、动态端口转发