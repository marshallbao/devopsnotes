#### IPFS 端口：

- Swarm 默认端口： 4001
  - 该端口用于 IPFS 节点之间的通信，实现了 IPFS 网络中节点之间的数据传输。
- API 默认端口：** 5001
  - 通过该端口可以与 IPFS 节点进行交互，如添加文件、获取文件或查看节点信息等。
- 网关端口： 8080
  - 该端口允许通过 HTTP 访问 IPFS 内容，您可以通过 Web 浏览器访问 IPFS 存储的内容。

#### IPFS Cluster 端口：

- Cluster API 默认端口： 9094
  - IPFS Cluster 使用此端口提供 API，用于管理 IPFS 集群以及跟踪和复制 IPFS 数据。
- Raft 默认端口： 9096
  - 在 IPFS Cluster 中，Raft 用于一致性协议，通常使用默认端口 9096 进行通信。