#### PodDisruptionBudget

保证 POD 主动逃离的情况下业务不中断或者业务SLA不降级，目的是对主动驱逐的保护措施。（就是在主动驱逐

pod的时候报证pod的数量不少于某个数值）

```
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  name: etcd
  namespace: spark-v2
spec:
  minAvailable: 51%
  selector:
    matchLabels:
      app.kubernetes.io/component: etcd
      app.kubernetes.io/instance: etcd
      app.kubernetes.io/name: etcd
```





