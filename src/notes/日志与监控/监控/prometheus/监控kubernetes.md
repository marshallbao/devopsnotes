

### cadvisor 

由谷歌开源，cadvisor 不仅可以搜集一台机器上所有运行的容器信息，还提供基础查询界面和http接口，方便其他组件如Prometheus进行数据抓取，cAdvisor可以对节点机器上的资源及容器进行实时监控和性能数据采集，包括CPU使用情况、内存使用情况、网络吞吐量及文件系统使用情况;

cadvisor 现在已经集成到了 kubelet 里面采集 pod 和 node 的相关数据，cpu,内存,网络默认是不采集的，因为采集网络资源会明显增加 cpu 的负载；

### kube-state-metrics

是一个简单的服务，它监听 Kubernetes API 服务器并生成有关对象状态的指标。它不关注单个 Kubernetes 组件的运行状况，而是关注内部各种对象的运行状况，主要是监控 kubernetes 各种对象的状态，比如 pod 的状态，deploy 部署是否正常等等

以上 cadvisor 和 kube-state-metrics 都可以通过 job 对接到 pormetheus 监控里面，监控集群及应用情况，可以根据实际情况进行使用；

### kube-metric-server 

是一个集群范围内资源使用情况的数据聚合器；作为一个应用部署在集群中，Metrics Server 从每个节点上的kubelet API-Server 收集指标，通过 k8s 聚合器注册在Master APIServer中；可用于 Kubernetes 的高级编排，例如 Horizontal Pod Autoscaler 自动伸缩;

kube-metric-server的数据其实就是来自 kubelet 的cAdvisor，采集数据流程：kubectl top -> apiserver -> metrics-server pod -> kubectl(cadvisor)，主要用法：kubectl top pods/nodes;

### node_exporter

监控主机相关资源

### blackbox-exporter

进行黑盒监控，支持 http,tcp,dns,icmp,POST 接口,SSL 证书过期时间

### 各种 exporter

各种中间件的 exporter ，例如：mongo、mysql、redis，以独立 pod 或者 sidecar 形式存在

### 业务 metrics

服务自己暴露的 metrics，通过svc、deploy、pod 来暴露，通过 prometheus 对应的 job 来获取 metrics 值







