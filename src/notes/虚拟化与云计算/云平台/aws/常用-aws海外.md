# AWS 海外

### 价格计算器

https://calculator.aws/#/



### EKS 

购买 eks 的坑

1、创建 eks 集群需要创建 eksClusterRole 角色

2、添加节点需要创建 AmazonEKSNodeRole  角色，包含以下策略

- AmazonEKSWorkerNodePolicy
- AmazonEC2ContainerRegistryReadOnly
- AmazonEKS_CNI_Policy

3、CNI 插件需要配置权限，将 AmazonEKS_CNI_Policy 附加到已与您的工作线程节点关联的 IAM 角色即AmazonEKSNodeRole 角色（如果第二步做了那这步就不需要了）

对于 3 最好的做法是，建议使用针对服务账户的 IAM 角色仅为 VPC CNI 插件提供其所需的权限，而不向节点 IAM 角色提供扩展权限。参考 https://docs.aws.amazon.com/zh_cn/eks/latest/userguide/cni-iam-role.htm

4、EBS CSI 驱动需要创建角色并通过 annotations 绑定至 EBS CSI 对应的 sa ，从而获得权限

5、 ingress LB 一定要选择 4 层 的 lb 即 nlb

#### 参考

https://docs.aws.amazon.com/zh_cn/eks/latest/userguide/create-node-role.html



### EC2



### RDS

1、Pod 的 ip 也要加入到对应的安全组