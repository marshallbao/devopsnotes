### kube-proxy

`kube-proxy` 是 Kubernetes 中的一个网络代理，它在每个节点上运行，负责处理网络服务的通信。具体来说，`kube-proxy` 的主要作用包括：

1. **服务发现和负载均衡**：
   - `kube-proxy` 负责实现 Kubernetes Service 的服务发现和负载均衡机制。它根据 Kubernetes API Server 提供的服务信息，维护了一张服务和后端 Pod 的映射表。
   - 当客户端访问一个服务时，`kube-proxy` 会将请求转发到该服务的一个后端 Pod 上，实现负载均衡。
2. **流量转发**：
   - `kube-proxy` 通过设置 iptables 规则或 IPVS（IP Virtual Server）规则，将到达服务 IP（ClusterIP）的流量转发到相应的后端 Pod。
   - 它支持三种模式：userspace 模式、iptables 模式和 IPVS 模式。其中，iptables 模式和 IPVS 模式是最常用的，性能较好。
3. **网络策略和安全**：
   - `kube-proxy` 还负责处理与网络策略相关的部分，确保只有符合策略的流量才能通过。

#### kube-proxy 的工作原理

- iptables 模式：

  - `kube-proxy` 使用 iptables 规则来实现服务 IP 到后端 Pod 的流量转发。它会在每个节点上设置大量的 iptables 规则，这些规则定义了如何将服务 IP 的流量转发到后端 Pod。

- IPVS 模式：

  - IPVS 模式使用 Linux 内核的 IPVS 模块来实现更高效的流量转发。相比于 iptables 模式，IPVS 模式具有更高的性能和更好的扩展性，适用于大规模集群。
  - 当创建 service 之后，kube-proxy 会在所在宿主机上创建一个虚拟网卡（ kube-ipvs0 ）,并为他分配clusterIP ,然后 kube-proxy 通过 IPVS 模块，为这个地址创建 n 个虚拟主机（虚拟主机就是后端podip+port），实现了负载均衡与代理；其实ipvs模式也需要 iptables 来实现包过滤，SNAT 等操作。不过这些数据清理操作是有限的并不会随着pod增加而增加。< 通俗的来说：pod 访问 clusterip 出主机的时候被 iptables 发现，进行处理传到 ipvs 模块，获取pod 地址，然后通过 flannel 直接访问 pod >