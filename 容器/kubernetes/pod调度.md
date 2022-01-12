# pod调度

### nodeSelector

提供简单的节点调度机制，pod根据一个或多个label来选择node

```
spec:
  containers:
  - name: nginx
    image: nginx
imagePullPolicy: IfNotPresent
nodeSelector:
  disktype: ssd
```

### nodeAffinity

节点亲和性分为软策略和硬策略，软是尽可能满足，如果满足不了也能调度到某个节点上运行，硬策略如果没有满足策略的节点，pod就一直在penging状态。

软策略：requiredDuringSchedulingIgnoredDuringExecution

硬策略：preferredDuringSchedulingIgnoredDuringExecution

IgnoredDuringExecution：如果一个pod所在的节点 在Pod运行期间其标签发生了改变，不再符合该Pod的节点亲和性需求，则系统将忽略Node上Label的变化，该pod继续在该节点上运行。

```
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution: #hard条件必须匹配
        nodeSelectorTerms:
        - matchExpressions:
          - key: kubernetes.io/hostname
            operator: In #支持In, NotIn, Exists, DoesNotExist, Gt, Lt
            values:
            - node0
            - node1
      preferredDuringSchedulingIgnoredDuringExecution: #soft条件优先匹配
      - weight: 1  #取值范围1-100
        preference:
          matchExpressions:
          - key: kubernetes.io/hostname
            operator: In
            values:
            - node2
```

###  Inter-pod affinity and anti-affinity

Pod亲和性和和反亲和性

pod亲和性与反亲和性是根据pod的label来选择node,和节点亲和性一样也有软策略和硬策略

topologyKey（拓扑）：用来描述一个区域/范围，实际上就是选择一个label进行匹配，label可以是主机，机房，机柜，城市等，也就是说可以将pod调度到目标pod所在的主机，机房，机柜，城市。

因为pod是用namespace来隔离的，所以也可以指定namespace，用来限定schedulerr调度时查找的namespace和pod。

```
        podAntiAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
          - labelSelector:
              matchExpressions:
              - key: appname
                operator: In
                values:
                - dbpool-server
            topologyKey: kubernetes.io/hostname
            namespaces:  #这样只会查找poa-ea和pletest下面的pod，而不是全部
            - poa-ea
            - pletest
```

Pod亲和性和Pod反亲和性

```
spec:
  affinity:
    podAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
      - labelSelector:
          matchExpressions:
          - key: security
            operator: In
            values:
            - S1
        topologyKey: failure-domain.beta.kubernetes.io/zone
    podAntiAffinity:
      preferredDuringSchedulingIgnoredDuringExecution:
      - weight: 100
        podAffinityTerm:
          labelSelector:
            matchExpressions:
            - key: security
              operator: In
              values:
              - S2
          topologyKey: kubernetes.io/hostname
```

注意：

1、Inter-pod affinity and anti-affinity需要消耗大量计算资源，会增加调度时间。如果node数量超过几百台的时候不建议使用。

2、Pod反亲和性必须指定 topologyKey 不能为空。















