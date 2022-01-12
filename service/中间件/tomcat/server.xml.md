​         <Server>元素
​        代表了整个Catalina   Servlet容器,它是Tomcat实例的顶层元素.可包含一个或多个<Service>元素.


        <Service>元素
        包含一个<Engine>元素,以及一个或多个<Connector>元素,这些<Connector>元素共享同一个<Engine>元素.


        <Connector>元素
        代表和客户程序实际交互的组件,他负责接收客户请求,以及向客户返回响应结果.


        <Engine>元素
        每个<Service>元素只能包含一个<Engine>元素.   <Engine>元素处理在同一个<Service>中所有<Connector>元素接收到的客户请求.


        <Host>元素
        一个<Engine>元素中可以包含多个<Host>元素.每个<Host>元素定义了一个虚拟主机,它可以包含一个或多个Web应用.


        <Context>元素
        每个<Context>元素代表了运行虚拟主机上的单个Web应用.一个<Host>元素中可以包含多个<Context>元素.
        
        
        
下面是server.xml文件的样例:
\1.     配置Server元素


        <Server>元素代表了整个Catalina Servler容器,它是Tomcat实例的顶层元素,由org.apache.catalina.Server接口来定义.<Server>元素中可以包含一个或者多个<Service>元素,但<Server>元素不能作为任何其他元素的子元素.范例代码中定义的<Server>元素如下:


            <Server     port="8005"     shutdown="SHUTDOWN"     debug="0">
          <Server>属性含义:


\--------------------------------------------------------------
          className :指定实现org.apache.catalina.Server接口的类,默认值为org.apache.catalina.core.StandardServer.
          port :指定Tomcat服务器监听shutdown命令的端口.终止Tomcat服务运行时,必须在Tomcat服务器所在的机器上发出Shutdown命令.该属性是必须设定的.
          shutdown :指定终止Tomcat服务器运行时,发给Tomcat服务器的shutdown监听端口的字符串.该属性是必须设定的.
\2. 配置Service元素


          <Service>元素由org.apache.catalina.Service接口定义,它包含一个<Engine>元素,以及一个或多个<Connector>元素,这些<Connector>元素共享一个<Engine>元素.    
 例如,在范例文件中配置了两个<Service>元素


          <Service     name="Catalina">
           <Service    name="Apache">
          第一个<Service>处理所有直接由Tomcat服务器接收的Web客户请求,第二个<Service>处理由Apache服务器转发过来的Web客户请求.


          <Service>属性含义:


\--------------------------------------------------------------
          className       :指定实现org.apache.catalina.Service接口的类,默认值为org.apache.catalina.core.StandardService.
          name                 :定义Service的名字.


\3.     配置Engine元素


          <Engine>元素由org.apahe.catalina.Engine接口定义.     每个<Service>元素只能包括一个<Engine>元素.    <Engine>元素处理在同一个<Service>中所有<Connector>元素接收到的客户请求.     例如,在范例server.xml文件中配置了一下的<Engine>元素:


          <Engine     name="Catalina"     defaultHost="localhost"     debug="0">  


          <Engine>属性含义:


\--------------------------------------------------------------
          className       :指定实现org.apache.catalina.Engine接口的类,默认值为org.apache.catalina.core.StandardEngine.
          name                 :定义Engine的名字.


          在<Engine>元素中可以包含如下的子元素:
                  <Logger>
                  <Realm>
                  <Valve>
                  <Host>


\4.     配置Host元素


          <Host>元素由org.apache.catalina.Host接口定义.一个<Engine>元素可以包含多个<Host>元素.每个<Host>元素定义了一个虚拟主机,它可以包含一个或多个Web应用.     例如,在样例server.xml中配置了以下<Host>元素:


                <Host     name="localhost"     debug="0"     appBase="webapps"
                            unpackWARs="true"     autoDeploy="true">  


          以上代码定义了一个名为localhost的虚拟主机,Web客户访问它的URL为:     http://localhost:8080/


          <Host>属性含义:
\--------------------------------------------------------------
          className           :指定实现org.apache.catalina.Host接口的类,默认值为org.apache.catalina.core.StandardHost.
          appBase               :指定虚拟主机的目录,可以指定绝对目录,也可以指定相对于<CATALINA_HOME>的相对目录.     如果此项没有设定,默认值为<CATALINA_HOME>/webapps.
          unpackWARs :如果此项设为true,表示将把Web应用的WAR文件先展开为开放目录结构后再运行.如果设为false,将直接运行WAR文件.
          autoDeploy :如果此项设为true,表示当Tomcat服务器处于运行状态时,能够监测appBase下的文件,如果有新的Web应用加入进来,会自动发布这个Web应用.
          alias :指定虚拟主机的别名,可以指定多个别名.
          deployOnStartup :如果此项设为true,表示Tomcat服务器启动时会自动发布appBase目录下的所有Web应用,如果Web应用在server.xml中没有相应的<Context>元素,将采用Tomcat默认的Context.     deployOnStartup的默认值为true.
          name                     :定义虚拟主机的名字.}


          在<Host>元素中可以包含如下的子元素:
                  <Logger>
                  <Realm>
                  <Valve>
                  <Context>


\5.     配置Context元素


          <Context>元素由org.apache.catalina.Context接口定义.     <Context>元素是使用最频繁的元素.     每个<Context>元素代表了运行在虚拟主机上的单个Web应用.     一个<Host>元素中可以包含多个<Context>元素.     例如,     在样例server.xml文件中配置了以下<Context>元素:


                 <Context     path="/sample"     docBase="sample"     debug="0"     reloadable="true">      


          <Context>属性含义:
\--------------------------------------------------------------
          className         :指定实现org.apache.catalina.Context接口的类,默认值为org.apache.catalina.core.StandardContext.
          path                   :指定访问该Web应用的URL入口.
          docBase             :指定Web应用的文件路径.可以给定绝对路径,也可以给定相对于Host的appBase属性的相对路径.     如果Web应用采用开放目录结构,那就指定Web应用的根目录;如果Web应用是个WAR文件,那就指定WAR文件的路径.
          reloadable       :如果这个属性设为true,Tomcat服务器在运行状态下会监视在WEB-INF/class和WEB-INF/lib目录下CLASS文件的改动.如果检测到有calss文件被更新,服务器会自动重新加载Web应用.
          cookies             :指定是否通过Cookie来支持Session,默认为true.
          useNaming         :指定是否支持JNDI,默认为true.


          在<Context>元素中可以包含如下的子元素:
                  <Logger>
                  <Realm>
                  <Valve>
                  <Resource>
                  <ResourceParams>


\6.     配置Connector元素


          <Connector>元素由org.apache.catalina.Connector接口定义.<Connector>元素代表与客户程序实际交互的组件,它负责接收客户的请求,以及向客户返回响应结果.例如,     在样例server.xml文件中配置了两个<Connector>元素:


              prot="8009"
                                    enableLookups="false"     redirectPort"8443"     debug="0"
                                    protocol="AJP/1.3"/>   
   
   第一个<Connector>元素定义了一个HTTP     Connector,它通过8080端口接收HTTP请求;
          第二个<Connector>元素定义了一个JK     Connector,它通过8009端口接收由其他HTTP服务器(如Apache服务器)转发过来的客户请求.


          所有的<Connector>元素都具有一些共同的属性,这些属性如下:     <Connector       <Connector     port="8080"
                                    maxThreads="150"     minSpareThreads="25"     maxSpareThreads="75"
                                    enableLookups="false"     redirectPort="8443"     acceptCount="100"
                                    debug="0"     connectionTimeout="20000"  
                                    disableUploadTimeout="true"     />  
          <Connector>属性含义(共同属性):


\--------------------------------------------------------------
          className               :指定实现org.apache.catalina.Connector     接口的类,默认值为org.apache.catalina.core.StandardConnector.
          enableLookups       :如果设为true,表示支持域名解析,可以把IP地址解析为主机名.Web应用调用request.getRemostHost方法将返回客户的主机名.该属性默认值为true.
          redirectPort         :指定转发端口.如果当前端口只支持non-SSL请求,在需要安全通信的场合,将把客户请求转发到基于SSL的redirectPort的端口.


          HttpConnector的属性描述如下:
\--------------------------------------------------------------
          calssName               :指定实现org.apache.catalina.Connector接口的类,默认值为org.apache.coyote.tomcat5.CoyoteConnector.
          enableLookups       :同上.
          redirectPort         :同上.
          prot                         :设定TCP/IP断口号,默认为8080.
          address                   :如果服务器有两个以上IP地址,该属性可以设定端口监听的IP地址,默认情况下,端口会监听服务器上所有IP地址.
          bufferSize             :设定由端口创建的输入流的缓存大小,默认值为2048byte.
          protocol                 :设定HTTP协议,默认值为HTTP/1.1.
          maxThreads             :设定处理客户请求的线程的最大数目,这个值也决定了服务器可以同时响应客户请求的最大数目,默认值为200.
          acceptCount           :设定在监听端口队列中的最大客户请求数,默认值为10.     如果队列已满,客户请求将被拒绝.
          connectionTimeout     :定义建立客户连接超时的时间,以毫秒为单位.如果设置为-1,表示不限制建立客户连接的时间.


          JK     Connector     的属性如下:
\--------------------------------------------------------------
          className               :指定实现org.apache.catalina.Connector接口的类,默认值为org.apache.coyote.tomact5.CoyoteCnnector.
          enableLookups       :同上.
          redirectPort         :同上.
          port                         :设定AJP端口号.
          protocol                 :必须设定为AJP/1.3协议.