## Dockerfile

#### 常用

FROM
指定基础镜像

LABEL
指定生成镜像的元数据标签信息

WORKDIR
工作目录
WORKDIR /app

COPY
用于从Docker 主机复制文件至创建的新映像文件(只复制目录内容不包含目录本身)
还可以用于 multi-stage builds，将前一阶段构建的产物拷贝到另一个镜像中,或者是将另一个镜像中的文件copy到此镜像中

WORKDIR /app
COPY checkredis.py .COPY --from=build:02 /App/test /tmp/test

ADD
类似COPY，还支持了TAR文件自动解压和URL路径<下载远程文件>（COPY是ADD的简化版本）
WORKDIR /app
ADD nickdir.tar.gz .

VOLUME
用于在image中创建一个挂载点目录，以挂载Dockerhost上的卷或其他容器的卷
VOLUME ["/my_files"]

EXPOSE
用于为容器打开指定要监听的端口以实现与外部通信（切勿映射host port）

EXPOSE 80
ARG
只应用于build过程（在做镜像的时候进行传递）
docker build --build-arg author="pony<pony@qq.com>" -t myweb:v0.3-10 .

ENV
用于容器运行后（在run的时候传递）用于为镜像定义所需的环境变量
ENV SERVER_WORKS 4docker run --name tinyweb1 --rm -P --env SERVER_WORKS=5 tinyhttpd:v0.1-7 printenv
此环境变量比在镜像中的变量优先级高
关于ARG和ENV,建议临时使用一下的变量适合使用ARG，与环境配置有关的变量要在启动的时候配置，提高镜像的复用率

RUN
指令运行于映像文件构建过程中，而CMD命令运行于基于Dockerfile构建出的新映像文件启动一个容器时
  RUN COMMAND1 && \
   COMMAND2 && \

CMD
默认的容器启动执行命令（可被 run 和 entrypoint 覆盖）,多个 CMD 只有最后一个生效

1.CMD ["executable","param1","param2"] (exec form, this is the preferred form)

2.CMD ["param1","param2"] (as default parameters to ENTRYPOINT)

3.CMD command param1 param2 (shell form ) 用法1 (推荐)

FROM centos
CMD ["/bin/bash", "-c", "echo 'hello cmd!'"] 用法3

FROM centos
CMD echo "hello cmd!"

USER
指定用户或userid
USER 751

ONBUILD
定义触发器，当自己的镜像被别人 from 时执行已定义的命令

#### Shell 形式和 exec形式

```
# shell 形式
CMD ["executable", "param1", "param2"]

- Shell 形式的 CMD 会通过 /bin/sh -c 执行。这意味着它运行在一个 shell 环境中
- 由于在 shell 中执行，这一形式允许使用 shell 特性，如环境变量替代、命令链（&&, ||）以及重定向。
- Shell 形式会引入额外的 shell 层，可能导致问题如信号传递和调试困难

# exec 形式
CMD command param1 param2

- Exec 形式直接执行可执行程序，没有使用 shell 解释器。
- 更明确：参数直接作为数组元素传递，不会因为 shell 特性的影响而产生歧义。

```



#### CMD&entrypoint

只有 cmd

cmd  为容器的启动命令/程序；如果 docker run 有指定命令则覆盖 cmd

只有 entrypoint

entrypoint 为容器的启动命令/程序；如果 docker run 有指定命令则作为 entrypoint 的参数

cmd 和 entrypoint 都有

entrypoint 为容器的启动命令/程序；cmd 作为 entrypoint 的参数

docker run 命令行参数优先级高于 cmd 和 entypoint

#### 多阶段构建

FROM nginxbuild:01 as build
WORKDIR /app
RUN echo "Build" >> /app/testFROM nginxrun:01
COPY --from=build /app/test /tmp/test

docker build -t nginxrun:02 -f run/Dockerfile .

保存
docker save -o web.tar nginx:latest
docker load -i web.tar

cache
遍历本地所有镜像，发现镜像与即将构建出的镜像一致时，将找到的镜像作为 cache 镜像，复用 cache 镜像作为构建结果。

第一次
FROM ubuntu:14.04
WORKDIR /app
RUN apt-get update
ADD run.sh /
CMD ["./run.sh"]

第二次
FROM ubuntu:14.04
WORKDIR /app

RUN apt-get update
ADD run.sh /
CMD ["./run.sh"]

注意
1、ADD 命令与 COPY 命令

2、RUN 命令存在外部依赖

3、一次新镜像的成功构建将导致后续的 cache 机制全部失效

总结

使用cache

将更多静态的安装、常规配置命令尽可能地放在 Dockerfile 的较前位置。

不使用 cache

docker build --no-cache 

  