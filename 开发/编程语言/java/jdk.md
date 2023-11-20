### JDK

目录说明

| 点击这里    | 点击这里                                                     |
| ----------- | ------------------------------------------------------------ |
| bin目录     | 包含一些用于开发Java程序的工具，例如：编译工具(javac.exe)、运行工具 (java.exe) 、打包工具 (jar.exe)等。 |
| db目录      | 纯Java开发的数据库 Derby，是一个开源的100%Java开发的关系数据库。 |
| include目录 | C语言的头文件，用于支持Java程序设计。                        |
| jre目录     | Java运行时环境的根目录。                                     |
| jre\bin目录 | 包含Java平台所使用工具和类库的可执行文件和DLL文件。          |
| jre\lib目录 | Java运行时环境所使用的核心类库。                             |
| lib目录     | 包含开发Java程序所使用的类库文件。                           |
| src.zip     | 归档的Java源代码                                             |

### 环境变量

对于JDK所需要配置的 3 个环境变量

**JAVA_HOME**

​      1. 方便配置 path 和 classpath 的变量值。即使当你本地的JDK的路径发生变化时，只需要去修改 JAVA_HOME的配置路径即可

​      2. 对于一些基于 java 编写成的软件，在这些软 件运行时，可以更好的找到虚拟机的路径。例如 Eclipse，其本事是由java编写的，那么它在运行的时候必然需要虚拟机的存在，那么 Eclipse 就可以通过这个配置变量找到虚拟机的目录

**PATH**

主要就是指定命令的搜索路径。比如 javac/java 等一些操作命令。

**classpath**

用来寻找Java源文件，及.class运行文件的路路径

### 环境安装



```
# 下载安装，可以去官网，也可以用自己的
tar -xf jdk-8u251-linux-x64.tar.gz

# 配置环境变量
export JAVA_HOME=/usr/local/jdk1.8.0_251
export PATH=$PATH:/usr/local/jdk1.8.0_251/bin
export CLASSPATH=/usr/local/jdk1.8.0_251/lib

# 检查
java -version
```





