### 概念





### 常用命令

```
helm repo update
helm search hub xxx
helm search repo grafana
helm search repo  bitnami/grafana -l
helm pull bitnami/grafana --version 8.4.6
```

helm search hub 搜索 Artifact Hub，该仓库列出了来自不同仓库的大量chart

helm search repo 搜索已经(用 helm repo add)加入到本地helm客户端的仓库

命令只搜索本地数据，不需要连接网络。

helmns get manifest  ingress-nginx -n x