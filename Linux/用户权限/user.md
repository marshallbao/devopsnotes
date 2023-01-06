### useradd

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
useradd -g root -m -d  /home/yonggui yonggui
```

usermod
chapasswd：批量修改密码
passwd
非交互式修改密码：
echo 123456 | passwd --stdin user002

echo "user003:123456" | chpasswd

groupadd -g 1005 gitlab-runner
useradd -d  /home/gitlab-runner -u 1005 -g gitlab-runner gitlab-runner

