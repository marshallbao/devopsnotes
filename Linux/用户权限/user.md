​         useradd
usermod
chapasswd：批量修改密码
passwd
非交互式修改密码：
echo 123456 | passwd --stdin user002

echo "user003:123456" | chpasswd

groupadd -g 1005 gitlab-runner
useradd -d  /home/gitlab-runner -u 1005 -g gitlab-runner gitlab-runner