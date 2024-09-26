在该列表中，有两个特殊的控制器：MutatingAdmissionWebhook 和 ValidatingAdmissionWebhook。 它们根据 API 中的配置， 分别执行变更和验证准入控制 Webhook。

在 Kubernetes 中，Admission Webhook 是一种允许您在 Kubernetes API 请求的生命周期中执行自定义逻辑的机制。Admission  Webhook 主要有两种类型：`MutatingWebhookConfiguration` 和 `ValidatingWebhookConfiguration`。它们分别用于不同的目的和场景。

#### MutatingWebhookConfiguration

**作用**：

- `MutatingWebhookConfiguration` 用于在资源被创建或更新时修改请求对象。它允许您在资源被存储到 etcd 之前对其进行修改

**使用场景**：

- 自动补全未提供的字段。
- 根据特定规则修改资源的配置。
- 添加默认值或标签。



#### ValidatingWebhookConfiguration

**作用**：

- `ValidatingWebhookConfiguration` 用于在资源被创建或更新时验证请求对象。它允许您在资源被存储到 etcd 之前对其进行验证，以确保请求符合预期的规则和策略。

**使用场景**：

- 验证资源配置的有效性。
- 强制执行策略和规则。
- 阻止不符合要求的资源被创建或更新。



#### 工作原理

1. **Webhook 注册**：`ValidatingWebhookConfiguration` 注册了一个 Admission Webhook，告诉 Kubernetes API 服务器在特定资源的创建或更新操作时调用该 Webhook。
2. **请求拦截**：当一个 Ingress 资源被创建或更新时，Kubernetes API 服务器会拦截这个请求并将其发送到注册的 Webhook 服务。
3. **Webhook 服务处理**：Webhook 服务接收到请求后，会执行自定义的验证逻辑，检查 Ingress 资源是否符合预期的规则。
4. **响应结果**：Webhook 服务返回一个响应，指示 API 服务器是否允许、拒绝或修改这个请求。
5. **请求执行**：根据 Webhook 服务的响应，API 服务器决定是否接受、拒绝或修改这个 Ingress 资源的创建或更新操作。