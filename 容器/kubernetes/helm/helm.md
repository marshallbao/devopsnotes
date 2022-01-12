helm search hub 搜索 Artifact Hub，该仓库列出了来自不同仓库的大量chart。

helm search repo 搜索已经(用 helm repo add)加入到本地helm客户端的仓库。该命名只搜索本地数据，不需要连接网络。
 helmns get manifest  ingress-nginx -n x