Open Policy Agent 即 OPA 是一个全场景通用的轻量策略引擎（Policy Engine），OPA 提供了声明式表达的 `Rego` 语言来描述策略，并将策略的决策 offload 到 OPA，从而将策略的决策过程从策略的执行中解耦。

OPA 整体架构的核心理念：为了更灵活和一致的架构，将 Policy 的决策过程从具体的服务解耦出去，也就是说虚拟出一层 策略决策层来做统一的策略处理，不涉及具体的业务逻辑。用统一的 DSL 和处理流程来完成 Policy 相关的逻辑，从而达到一致的架构设计。

### Rego

使用 Rego 语言进行策略的描述

Rego 语言为 OPA 项目提供一种领域无关的描述策略的声明式 DSL。涉及源于 datalog ，但是扩展了对 JSON 的支持。



### OPA 的使用方式

OPA 的运行依赖于 Rego 运行环境，因此 OPA 提供了两种主要的使用方式：

- **Go Library**：直接将 Rego 的运行环境以库的形式整合到用户服务中。当服务需要执行 Rego 代码时，只需要调用相关的 API 即可
- **REST API**：如果服务不是用 Go 编写，为了拥有 Rego 运行环境，此时则必须使用 REST API。OPA 提供了一个 HTTP 服务，当其他组件需要执行 Rego 代码时，则将代码和数据一起以 REST API 的形式传给 OPA HTTP 服务，待 Rego 执行完后将相应的结果返回

### 	在 kubernetes 中使用 --> gatekeeper

​	

### OPA不足

性能问题，OPA 的开销简单可分为两方面：**Policy 执行性能开销**和**引入 OPA 层可能带来的网络开销**。

目前国内OPA使用的还不广泛，相关资料较少，缺少最佳实践，需要自己踩坑。

然后Reog语言有上手门槛，需要学习才能够上手使用。

### 总结

策略抽离后带来的好处是充分解耦。在代码更容易维护、扩展的同时可以尽可能的减少由策略配置错误导致的Bug。以达到给客户提供更优质服务的目的。

使用OPA后我们可以对策略本身进行版本化、重复的测试、策略复用等。并且可以预见的是就像数据库、队列、CICD、编排等模块一样，策略从代码中抽离出来是未来的趋势，类似 policy as code。

参考：

https://blog.csdn.net/M2l0ZgSsVc7r69eFdTj/article/details/121005158

https://www.bianchengquan.com/article/457677.html

https://blog.csdn.net/tao12345666333/article/details/123267615

https://jishuin.proginn.com/p/763bfbd6eb9f

https://blog.csdn.net/sysushui/article/details/102769889

https://cloud.tencent.com/developer/article/1685485