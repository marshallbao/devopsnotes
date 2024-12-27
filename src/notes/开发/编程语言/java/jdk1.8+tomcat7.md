### jdk 1.8 + tomcat7  

1、日志路径需要建立软连接

2、/etc/profile 环境变量添加

3、服务启动路径变更（/www/）；server.xml 修改确认

4、jvm 参数变更（更改tomcat7启动脚本） max 内存  3/4 16 12288

5、日志切割脚本 cronolog

6、添加开机启动


jdk

```
解压：
rpm -ivh jdk-8u101-linux-x64.rpm

修改环境变量：
/etc/profile.d/javaenv.sh
export JAVA_HOME="/usr/java/jdk1.7.0_80"
export PATH="$PATH:$JAVA_HOME/bin"
export JRE_HOME="$JAVA_HOME/jre"
export CLASSPATH=".:$JAVA_HOME/lib:$JRE_HOME/lib"

测试：
java -version;
```




tomcat7

```
tar -xzvf tomcat7.tar.gz;
mv ./tomcat7 /etc/init.d/；
chmod 755 /etc/init.d/tomcat7；
ln -s  /etc/init.d/tomcat7 /etc/init.d/tomcat;
rm -rf logs;ln -s /data/tomcat7/logs/ /opt/tomcat7/logs；
mkdir -p /data/tomcat7/logs;mkdir -p /www/mobanker/webapps/;

日志切割 cronolog
cp /usr/sbin/cronolog /usr/local/sbin/;

开机自启
chkconfig --add tomcat7;chkconfig tomcat7 on；

修改JVM
vim /etc/init.d/tomcat7；
JAVA_OPTS="$JAVA_OPTS -server -Xms1024m -Xmx12288m   #为机器内存的2/3


日志目录
bin/catalina.sh

项目目录
server.xml
<Host name="localhost"  appBase="/www/mobanker/webapps"
            unpackWARs="true" autoDeploy="true">

测试：
curl http://ip:port
```


注意：防火墙及 SElinux