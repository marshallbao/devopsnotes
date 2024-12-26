# 理论

### 1、服务注册中心


提供服务注册 和发现服务功能
高可用：
通常来说，高可用集群需要3个节点，通过各个节点之间进行复制和互相注册来保障注册中心的高可用。任何一个注册中心节点挂掉对集群都不会有影响，甚至全部的eureka节点挂掉，客户端之间的调用也不受影响（客户端的ribbon会缓存服务注册列表，当然此时新的服务就没法注册了）

服务同步：
多个 eureka server 之间相互注册，服务提供者不管在哪个节点服务注册，该节点服务会把信息同步给集群的每个服务，从而实现数据同步，为的就是客户端访问到服务的任意节点都会获取完整的服务列表。

eureka server 提供了失效自动剔除和自我保护功能：
失效剔除：
有些时候，我们的服务提供方并不一定会正常下线，可能因为内存溢出、网络故障等原因导致服务无法正常工作。Eureka Server需要将这样的服务剔
除出服务列表。因此它会开启一个定时任务，每隔60秒对所有失效的服务（超过90秒未响应）进行剔除。
可以通过eureka.server.eviction-interval-timer-in-ms参数对其进行修改，单位是毫秒，生成环境不要修改。这个会对我们开发带来极大的不变，你对服务重启，隔了60秒Eureka才反应过来。开发阶段可以适当调整，比如10S

eureka:
server:
enable-self-preservation: false # 关闭自我保护模式（缺省为打开）
eviction-interval-timer-in-ms: 1000 # 扫描失效服务的间隔时间（缺省为60*1000ms）没1000毫秒扫描一次如果有down机的服务会进行剔除

自我保护：
当一个服务未按时进行心跳续约时，Eureka会统计最近15分钟心跳失败的服务实例的比例是否超过了85%。在生
产环境下，因为网络延迟等原因，心跳失败实例的比例很有可能超标，但是此时就把服务剔除列表并不妥当，因为服务可能没有宕机。Eureka就会把
当前实例的注册信息保护起来，不予剔除。生产环境下这很有效，保证了大多数服务依然可用。



### 2、服务提供者


服务提供者 需要在Eureka server 注册服务 并完成续约的工作

服务注册：
服务提供者在启动时，会检测配置属性中的：eureka.client.register-with-erueka=true参数是否正确，这个参数默认就是true，确实这个参数为true时会向eureka server 发起rest请求并携带自己的原数据信息，eureka server会吧这些信息保存到一个双层 map 结构中 第一层map的key 就是服务名称，第二层map的key就是服务实例的id。

服务续约：
在注册服务完成以后，服务提供者会维持一个心跳（定时向EurekaServer发起Rest请求），告诉EurekaServer：“我还活着”。这个我们称为服务的续
约（renew）；

有两个重要参数可以修改服务续约的行为： #注意：和eureka server 失效剔除 配合使用
eureka:
instance:
lease-expiration-duration-in-seconds: 90 #服务失效时间，默认值90秒
lease-renewal-interval-in-seconds: 30 #服务续约(renew)的间隔，默认为30秒

通俗的说就是服务提供者会每隔30秒会向eureka server 发送一次心跳，证明还活着，如果超过90秒没有发送 eureka server 会认为该服务宕机 会从服务列表剔除，这两个值生产环境不用修改，默认即可。



### 3、消费者


获取服务列表：
当服务消费者启动是，会检测* eureka.client.fetch-registry=true* 参数的值，如果为true，则会从Eureka Server服务的列表只读备份，然后缓存在本地。并且每隔30秒会重新获取并更新数据。我们可以通过下面的参数来修改：
eureka:
client:
registry-fetch-interval-seconds: 5

生产环境不用修改。

负载均衡Robbin
我们在测试时启动了一个user-service，然后通过DiscoveryClient来获取服务实例信息，然后获取ip和端口来访问
然而在实际开发中为了提高效率，我们往往会开启很多 user-service 集群 那到底去访问哪个

一般这种情况下我们就需要编写负载均衡算法，在多个实例列表中进行选择。
不过Eureka中已经帮我们集成了负载均衡组件：Ribbon，简单修改代码即可使用。
什么是Ribbon：

Ribbon 是 Netflix 发布的负载均衡器，它有助于控制 HTTP 和TCP 客户端的行为。为ribbon 配置服务体服务提供者地址列表后，ribbon 就可基于某种负载均衡算法，自动地帮助服务消费者去请求。ribbon默认为我们提供了很多负载均衡的算法，如轮询、随机等。当然，我们也可为 ribbon 实现自定义的负载均衡的算法。



### 4、重试机制


Eureka的服务治理强调了CAP原则中的AP，即可用性和可靠性。它与Zookeeper这一类强调CP（一致性，可靠性）的服务治理框架最大的区别在于：
Eureka为了实现更高的服务可用性，牺牲了一定的一致性，极端情况下它宁愿接收故障实例也不愿丢掉健康实例，正如我们上面所说的自我保护机
制。
但是，此时如果我们调用了这些不正常的服务，调用就会失败，从而导致其它服务不能正常工作！这显然不是我们愿意看到的。

因此Spring Cloud 整合了Spring Retry 来增强RestTemplate的重试能力，当一次服务调用失败后，不会立即抛出一次，而是再次重试另一个服务
只需要简单配置即可实现Ribbon的重试

spring:
cloud:
loadbalancer:
retry:
enabled: true # 开启Spring Cloud的重试功能
user-service:
ribbon:
ConnectTimeout: 250 # Ribbon的连接超时时间
ReadTimeout: 1000 # Ribbon的数据读取超时时间
OkToRetryOnAllOperations: true # 是否对所有操作都进行重试
MaxAutoRetriesNextServer: 1 # 切换实例的重试次数
MaxAutoRetries: 1 # 对当前实例的重试次数

根据如上配置，当访问到某个服务超时后，它会再次尝试访问下一个服务实例，如果不行就再换一个实例，如果不行，则返回失败。切换次数取决
于MaxAutoRetriesNextServer参数的值

# 配置


eureka
注册服务：service-url
服务发现，拉取服务:
服务治理：



### 服务提供方：


eureka:
  client:
    service-url:  # EurekaServer地址
      \#defaultZone: http://127.0.0.1:8769/eureka,http://127.0.0.1:8770/eureka  #map<key,value>
      defaultZone: http://127.0.0.1:8769/eureka
    \#register-with-eureka: true #将自己注册到eureka,默认为true，不用书写
    \#fetch-registry: true #拉取服务，默认为true
  instance:
    prefer-ip-address: true  # 当调用getHostname获取实例的hostname时，返回ip而不是host名称
    ip-address: 127.0.0.1 # 指定自己的ip信息，不指定的话会自己寻找,启动速度慢
    \#在注册服务完成以后，服务提供者会维持一个心跳（定时向EurekaServer发起Rest请求），告诉EurekaServer：“我还活着”。
    \#这个我们称为服务的续约（renew）
    \#心跳设置
    lease-renewal-interval-in-seconds: 5 # 5秒一次心跳，默认为30秒
    lease-expiration-duration-in-seconds: 10 # 10秒即过期，默认值90秒   expiration 到期  duration 持续时间
    \#服务注册的实例id设置
    \#默认格式是：${hostname} + ${spring.application.name} + ${server.port}
    instance-id: ${spring.application.name}:${server.port} #map<applicationname,map<instance-id,instance>>



### 服务消费者：


eureka:
  client:
    service-url:  # EurekaServer地址,注册中心地址
      \#defaultZone: http://127.0.0.1:8769/eureka,http://127.0.0.1:8770/eureka  #map<key,value>
      defaultZone: http://127.0.0.1:8769/eureka
    \#消费者拉取服务清单设置
    fetch-registry: true #消费者启动，从Eureka Server服务的列表只读备份，然后缓存在本地
    registry-fetch-interval-seconds: 5 #默认每隔30秒会重新获取并更新数据    interval 时间间隔

  instance:
    prefer-ip-address: true # 当其它服务获取地址时提供ip而不是hostname
    ip-address: 127.0.0.1 # 指定自己的ip信息，不指定的话会自己寻找



### Eureka注册中心：


eureka:
  client:
    register-with-eureka: true # 是否注册自己的信息到EurekaServer，默认是true
    fetch-registry: true # 是否拉取其它服务的信息，默认是true
    service-url: # EurekaServer的地址，现在是自己的地址，如果是集群，需要加上其它Server的地址。
      \#defaultZone: http://127.0.0.1:${server.port}/eureka
      defaultZone: http://127.0.0.1:8769/eureka

  \#失效剔除和自我保护
  \#因为网络延迟等原因，心跳失败实例的比例很有可能超标，但是此时就把服务剔除列表并不妥当，因为服务可能没有宕机
  \#每隔60秒对所有失效的服务（超过90秒未响应）进行剔除
  server:
    enable-self-preservation: false # 开发阶段会关闭自我保护模式（默认为打开）
    \#eviction 驱逐 interval 时间间隔
    eviction-interval-timer-in-ms: 1000 # 扫描失效服务的间隔时间（默认为60*1000ms），这里设置1秒