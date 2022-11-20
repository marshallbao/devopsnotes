# pod调度

## 调度器

 API Server在接受客户端提交Pod对象创建请求后，然后是通过调度器（kube-schedule）从集群中选择一个可用的最佳节点来创建并运行Pod。而这一个创建Pod对象，
  在调度的过程当中有3个阶段：节点预选、节点优选、节点选定，从而筛选出最佳的节点。

  节点预选：基于一系列的预选规则对每个节点进行检查，将那些不符合条件的节点过滤，从而完成节点的预选
  节点优选：对预选出的节点进行优先级排序，以便选出最合适运行Pod对象的节点
  节点选定：从优先级排序结果中挑选出优先级最高的节点运行Pod，当这类节点多于1个时，则进行随机选择

 预选策略：       这么多策略，有的是不用的，不是一下都用的。想用的可以自己设置
  执行预选操作，调度器会逐一根据规则进行筛选，如果预选没能选定一个合适的节点，此时Pod会一直处于Pending状态，直到有一个可用节点完成调度。其常用的预选策略如下：

  CheckNodeCondition：检查是否可以在节点报告磁盘、网络不可用或未准备好的情况下将Pod对象调度其上。（检查节点是否正常的）

  HostName：如果Pod对象拥有spec.hostname属性，则检查节点名称字符串是否和该属性值匹配。
  PodFitsHostPorts：如果Pod对象定义了ports.hostPort属性，则检查Pod指定的端口是否已经被节点上的其他容器或服务占用。
  MatchNodeSelector：如果Pod对象定义了spec.nodeSelector属性，则检查节点标签是否和该属性匹配。
  NoDiskConflict：检查Pod对象请求的存储卷在该节点上可用。
  PodFitsResources：检查节点上的资源（CPU、内存）可用性是否满足Pod对象的运行需求。

  PodToleratesNodeTaints：如果Pod对象中定义了spec.tolerations属性，则需要检查该属性值是否可以接纳节点定义的污点（taints）。
  PodToleratesNodeNoExecuteTaints：如果Pod对象定义了spec.tolerations属性，检查该属性是否接纳节点的NoExecute类型的污点。   默认不启用
   pod调度到有污点的节点，如果节点的污点改了，pod不能接受了，默认pod是不会走。如果定义了这个，node污点改了，pod会溜，不接受。

  CheckNodeLabelPresence：仅检查节点上指定的所有标签的存在性，要检查的标签以及其可否存在取决于用户的定义。      默认不启用
  CheckServiceAffinity：根据当前Pod对象所属的Service已有其他Pod对象所运行的节点调度，目前是将相同的Service的Pod对象放在同一个或同一类节点上。  默认不启用

  MaxEBSVolumeCount：检查节点上是否已挂载EBS存储卷数量是否超过了设置的最大值，默认值：39  亚马逊相关的存储
  MaxGCEPDVolumeCount：检查节点上已挂载的GCE PD存储卷是否超过了设置的最大值，默认值：16  google相关的存储
  MaxAzureDiskVolumeCount：检查节点上已挂载的Azure Disk存储卷数量是否超过了设置的最大值，默认值：16

  CheckVolumeBinding：检查节点上已绑定和未绑定的PVC是否满足Pod对象的存储卷需求。
  NoVolumeZoneConflct：在给定了区域限制的前提下，检查在该节点上部署Pod对象是否存在存储卷冲突。
  CheckNodeMemoryPressure：在给定了节点已经上报了存在内存资源压力过大的状态，则需要检查该Pod是否可以调度到该节点上。
  CheckNodePIDPressure：如果给定的节点已经报告了存在PID资源压力过大的状态，则需要检查该Pod是否可以调度到该节点上。
  CheckNodeDiskPressure：如果给定的节点存在磁盘资源压力过大，则检查该Pod对象是否可以调度到该节点上。
  MatchInterPodAffinity：检查给定的节点能否可以满足Pod对象的亲和性和反亲和性条件，用来实现Pod亲和性调度或反亲和性调度。

 在上面的这些预选策略里面，CheckNodeLabelPressure和CheckServiceAffinity可以在预选过程中结合用户自定义调度逻辑，这些策略叫做可配置策略。其他不接受参数进行自定义配置的称为静态策略。

## 优先函数

  LeastRequested：  相比来说，空闲的节点胜出
  （cpu((capacity-sum(requested))*10/capacity)+memory((capacity-sum(requested))*10/capacity))/2  

  BalancedResourceAllocation： 
   CPU和内存资源被占用率相近的胜出；  

   cpu得分为5，内存得分也为5，适合。cpu得分为8，内存得分为5，不如上一个适合。

  NodePreferAvoidPods:  
   节点注解信息“scheduler.alpha.kubernetes.io/preferAvoidPods”  

  TaintToleration：将Pod对象的spec.tolerations列表项与节点的taints列表项进行匹配度检查，匹配条目越多，得分越低；
      
  SeletorSpreading：比如123三个节点，svc选择3节点上的一个pod，后来这个pod副本变成2了，那么pod启动在12节点，不会再在3上面挤。

  InterPodAffinity：  

  NodeAffinity：  

  MostRequested：  相比来说，繁忙的节点胜出

  NodeLabel：  

  ImageLocality：根据满足当前Pod对象需求的已有镜像的体积大小之和  

## 调度策略

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















