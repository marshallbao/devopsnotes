## Dockerfile

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
默认的容器启动执行命令（可被run和entrypoint覆盖）,多个CMD只有最后一个生效
1.CMD ["executable","param1","param2"] (exec form, this is the preferred form)

2.CMD ["param1","param2"] (as default parameters to ENTRYPOINT)

3.CMD command param1 param2 (shell form)用法1(推荐)
FROM centos
CMD ["/bin/bash", "-c", "echo 'hello cmd!'"]用法3
FROM centos
CMD echo "hello cmd!"docker run web
Shell形式和exec形式之间有两个区别
1、exec形式被解析为JSON数组，命令或参数要用双引号而不是单引号；
2、exec表单不会调用shell；
CMD echo $HOME 
CMD ["/bin/sh","-c","echo $HOME"]
CMD ["/bin/echo","$HOME"] ❌
适用场景：无需预处理配置，无需修改参数，比较固定的服务或任务
用法2
FROM centos
CMD ["hello cmd"]
ENTRYPOINT
用于为容器指定默认的运行程序且不会被docker run 参数所覆盖,如果同时存在cmd和entypoint，cmd会被当作参数传递给entypoint ，命令行参数优先级高于cmd参数传递给entypoint
1.ENTRYPOINT ["executable", "param1", "param2"] (exec form, preferred)
2.ENTRYPOINT command param1 param2 (shell form)用法1（推荐）
FROM centos
CMD ["p in cmd"]
ENTRYPOINT ["echo"]docker run web p in run
如果run命令后面有东西，那么后面的全部都会作为entrypoint的参数。如果run后面没有额外的东西，但是cmd有，那么cmd的全部内容会作为entrypoint的参数，这同时是cmd的第二种用法

适用场景：可变参数，需要初始化配置，exec "$@"


用法2
 CMD ["p in cmd"]
 ENTRYPOINT echo这种模式，run和cmd参数都无法传入，一般不用；
entrypoint是容器的入口必执行的,只有最后一条生效； 无论你用的是ENTRYPOINT还是CMD命令, 都建议采用exec表示法

USER
指定用户或userid
USER 751
ONBUILD
定义触发器，当自己的镜像被别人from时执行已定义的命令

构建
docker build：使用dockerfile 构建镜像
--tag, -t: 镜像的名字及标签，通常 name:tag 或者 name 格式；可以在一次构建中为一个镜像设置多个标签。
--build-arg=[] :设置镜像创建时的变量；
-f :指定要使用的Dockerfile路径；


docker build -t image-name -f /dir/Dockerfile
例：Dockerfile
FROM alpine
RUN date > /world.txt
CMD cat /world.txtdocker build -t image-name -f /dir/Dockerfile
docker tag name new-name；
docker push new-name；
多阶段构建
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
不使用cache
docker build --no-cache 

  