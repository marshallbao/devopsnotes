### API

Application Programming Interface（应用程序接口）是它的全称。简单的理解就是，API是一个接口



### REST

REST 就是一种设计API的模式/风格。

最常用的数据格式是JSON。由于JSON能直接被JavaScript读取，所以，以JSON格式编写的REST风格的API具

有简单、易读、易用的特点



### RPC

RPC 是远程过程调用（Remote Procedure Call）。 RPC 的主要功能目标是让构建分布式计算（应用）更容易，在提供强大的远程调用能力时不损失本地调用的语义简洁性

常用的框架

- **Dubbo**：国内最早开源的 RPC 框架，由阿里巴巴公司开发并于 2011 年末对外开源，仅支持 Java 语言。
- **Motan**：微博内部使用的 RPC 框架，于 2016 年对外开源，仅支持 Java 语言。
- **Tars**：腾讯内部使用的 RPC 框架，于 2017 年对外开源，仅支持 C++ 语言。
- **Spring****Cloud**：国外 Pivotal 公司 2014 年对外开源的 RPC 框架，提供了丰富的生态组件。
- **gRPC**：Google 于 2015 年对外开源的跨语言 RPC 框架，支持多种语言。
- **Thrift**：最初是由 Facebook 开发的内部系统跨语言的 RPC 框架，2007 年贡献给了 Apache 基金，成为Apache 开源项目之一，支持多种语言。



### gRPC

gRPC是一种 RPC 框架，它是基于Google的Protocol Buffers协议和HTTP/2协议构建的高性能、开源的、跨语言的RPC框架



### RPC/REST

RPC 适用于内网服务调用，对外提供服务请走 REST。

IO 密集的服务调用用 RPC，低频服务用 REST

服务调用过于密集与复杂，RPC 就比较适用



参考

https://www.zhihu.com/tardis/zm/art/426303359?source_id=1005

https://blog.csdn.net/u011482647/article/details/115480457

https://www.jianshu.com/p/e3c4b2837961

https://zhuanlan.zhihu.com/p/374901408