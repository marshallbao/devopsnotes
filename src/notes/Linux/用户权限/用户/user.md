### 命令相关

#### useradd

```
-g: 指定用户组
-m: 创建用户的登入目录
-M: 不要自动建立用户的登入目录
-s: 指定用户登入后所使用的shell,如果为 /sbin/nologin 或者 /bin/false
-d: 登入目录,指定用户登入时的起始目录
-G: 定义此用户为多个不同 groups 的成员
-u: 指定唯一 id

服务账号
groupadd mongod
useradd -g mongod -M -s /sbin/nologin mongod

普通用户
groupadd yonggui
useradd -g yonggui -m -d  /home/yonggui -s /bin/bash yonggui



```

#### adduser

注意：

adduser：会自动为创建的用户指定主目录、系统shell版本，会在创建时输入用户密码
useradd：需要使用参数选项指定上述基本设置，如果不使用任何参数，则创建的用户无密码、无主目录、没有指定shell版本。

#### userdel

```
# 删除用户username以及用户目录
userdel -r username
```



### 用户

```
# 
gpasswd -a user1 group1
```



### 密码

```
# 修改密码
passwd

# 批量修改密码
chapasswd

#非交互式修改密码
echo 123456 | passwd --stdin user002
echo "user003:123456" | chpasswd
```





参考

https://www.cnblogs.com/whoamme/p/16100633.html

https://blog.csdn.net/fured/article/details/117601598

https://blog.51cto.com/yangzhiheng/1966474

https://blog.csdn.net/wuguangbin1230/article/details/123084915