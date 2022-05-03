疑惑：gatekeeper 和admission webhooke 不是一回事吗？为啥要费劲搞出个这个东西来？

fuck  gatekeeper 是一种 admission webhooke ，需要注意的是 kubernetes 支持动态准入控制器也就是 admission webhooke，但是需要自己实现 gatekeeper 就是一种 admission webhooke

### Kubernetes 中使用 OPA

Gatekeeper 在 Kubernetes 中以 Pod 形式启动，启动后将向 API Server 中注册 `Dynamic Admission Controller`，本质上就是让 Gatekeeper 作为一个 Webhook Server。当用户使用 kubectl 或者其他方式向 API Server 发出对资源的 CURD 请求时，其请求经过 Authentication 和 Authorization 后，将发送给 Admission Controller，并最终以 `AdmissionReview` 请求的形式发送给 Gatekeeper。Gatekeeper 根据对应服务的 Policy（**以 CRD 形式配置**）对这个请求进行决策，并以 `AdmissionReview` 的响应返回给 API Server。







准入控制器有很多种内置的，webhook 是kube-api-server

动态准入控制器是可以根据自己的需求自定义各种准备控制器， webhook 也是kube-api-server

gatekeeper 是一种专业的 动态准入控制器webhooke， 可以自定义一些策略（准入控制器）