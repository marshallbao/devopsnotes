docker events:

​    -f:根据条件过滤事件；
​    --since ：从指定的时间戳后显示所有事件;
​    --until ：流水时间显示到指定的时间为止；


docker save -o images.tar images:tag
docker load -i images.tar

docker export containerId >images.tar
cat images.tar | docker import - images:tag

docker commit  a404c6c174a2  mymysql:v1 

docker save 和docker export以及docker commit的区别：

1. docker save保存的是镜像（image），docker export保存的是容器（container）
2. docker load用来载入镜像包，docker import用来载入容器包，但两者都会恢复为镜像
3. docker load不能对载入的镜像重命名，而docker import可以为镜像指定新名称
4. docker save 没有丢失镜像的历史，可以回滚到之前的层（layer）.docker export 会丢失镜像的历史（变成了1层）,回滚方法：(docker tag <LAYER ID> <IMAGE NMME>)
5. docker commit 就是将container当前的读写层保存下来，保存成一个新层,加上只读层做成一个新镜像（比之前的镜像多了一层）

docker inspect --format  #查看容器及镜像内容

docker stats 查看容器资源使用状态