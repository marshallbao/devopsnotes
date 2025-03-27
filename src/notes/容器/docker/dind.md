# Dind

Docker in Docker 是一种在 Docker 容器内运行 Docker 的技术。它可以让一个 Docker 容器变成一个独立的 

Docker 环境，从而可以创建和运行更多的 Docker 容器

两种方案

```
# 通过挂载主机 Docker 守护进程的 Unix socket 来实现
docker run -it --privileged -v /var/run/docker.sock:/var/run/docker.sock docker:dind sh

# 直接使用 docker:dind/docker:latest 镜像启动 dockerd 服务
docker run -d --privileged docker:dind


```

