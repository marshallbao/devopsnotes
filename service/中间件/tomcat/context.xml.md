​         server.xml是不可动态重加载的资源
context.xml 会定时扫描动态加载







jdbc
<Resource 
              name="jdbc/myoracle"   # 指定资源池的Resource的JNDI的名字
              auth="Container"          # 管理权限，指定管理Resource的Manager，可以是Container或Application。
              factory                         #指定DateResource的factory的名字。
              type="javax.sql.DataSource"            #指定Resource所属的类名，是什么类型的数据源。
              driverClassName="oracle.jdbc.OracleDriver"   #jdbc驱动
              url="jdbc:oracle:thin:@127.0.0.1:1521:mysid"   #见下面详解
              username="scott" 
              password="tiger" 
              maxTotal="20" 
              maxIdle="10"
              maxWaitMillis="-1"/>
              
url详解：
jdbc:表示采用jdbc方式连接数据库
oracle:表示连接的是oracle数据库
thin:表示连接时采用thin模式(oracle中有两种模式)

thin是一种瘦客户端的连接方式，即采用这种连接方式不需要安装oracle客户端,只要求classpath中包含jdbc驱动的jar包就行。thin就是纯粹用Java写的ORACLE数据库访问接口。
oci是一种胖客户端的连接方式，即采用这种连接方式需要安装oracle客户端。oci是Oracle Call Interface的首字母缩写，是ORACLE公司提供了访问接口，就是使用Java来调用本机的Oracle客户端，然后再访问数据库，优点是速度 快，但是需要安装和配置数据库。

maxActive：指定连接池中处于活动连接的最大数量，0表示不受限制。
maxIdle：指定连接池中空闲连接的最大数量，0表示不受限制。
maxWait：指定连接池中处于空闲状态的最大等待毫秒数，-1表示无限等待。
removeabandoned：为true时，表示自动回收超时连接。
removeabandonedtimeout：超时时间（以秒数为单位）
logabandoned：为true时，表示将在回收事件后，在log中打印回收连接的信息。


**context.xml的三个作用范围：**
\1. tomcat server级别：
在/conf/context.xml里配置。
\2. Host级别：
在/conf/Catalina/${hostName}里添加context.xml，继而进行配置。
\3. web app 级别：
在/conf/Catalina/${hostName}里添加${webAppName}.xml，继而进行配置。