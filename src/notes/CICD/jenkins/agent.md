jenkins agent 接入

##### 1、配置 agent

节点管理 --> 新建节点 --> 输入节点名称 --> 固定节点，填写主要信息

1. 名字  后期会通过此名称进行 label选择 调度
2. 远程工作目录  jenkins agent 的工作空间 cache 拉取的代码等
3. 启动 方式 使用java web方式启动

点击保存即可

##### 2、配置 agent 启动环境

下载安装 jdk17，配置环境变量

```
export PATH=$PATH:/usr/local/jdk-17.0.5/bin
export JAVA_HOME=/usr/local/jdk-17.0.5
```

##### 3、启动 agent

点击 agent 看到如下界面 使用里面的命令进行启动

```
# 下载 jar 包
curl -sO http://jenkins.bianjie.ai:8080/jnlpJars/agent.jar

# 启动
java -jar agent.jar -jnlpUrl http://jenkins.bianjie.ai:8080/computer/sh%2Ddeploy%2D02%2D83/jenkins-agent.jnlp -secret 6976ec4f19ab772022226208dfac88e742d5321211101a5ec56aa2b3caa4b4fc -workDir "/data/jenkins" &
```

##### 4、启动成功

