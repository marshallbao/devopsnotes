### 关于权限

创建 Amazon EKS 集群时，将为创建集群的 [IAM 主体](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_terms-and-concepts.html)自动授予 Amazon EKS 控制面板中基于集群角色的访问控制（RBAC）配置中的 `system:masters` 权限。该主体不会显示在任何可见配置中，**因此请确保跟踪最初创建集群的主体。**

#### 给其他 IAM 用户授予 EKS 的权限

1、新建 IAM 用户

2、授予 eks:DescribeCluster 权限（如果不授予，则无法执行 aws eks update-kubeconfig 命令，只能手动传递 kubeconfig 文件）

3、编辑 kube-system 下的 aws-auth configmap 文件

```
# 有两种方式
mapRoles：将角色传入集群进行绑定相关权限
mapUsers：将用户传入集群进行绑定相关权限

# 用 mapUsers 方式
# super-admin 权限
  mapUsers: |
    - groups:
      - system:masters
      userarn: arn:aws:iam::046241478227:user/ops@bianjie.ai
      username: ops@bianjie.ai

# group: kubernetes 的用户组
# userarn: IAM 角色的 arn 信息
# username: IAM 用户的名字
# 此处是将 ops@bianjie.ai 这个用户加入到了 system:masters 这个组里，而 system:masters 这个组已经通过 rbac 绑定了 super-admin 这个 clusterrole，从而拥有了 super-admin 权限


# 自定义权限
# 将 roles/clusterroles  绑定到组，这个组可以是自定义的组
  mapUsers: |
    - groups:
      - ops
      userarn: arn:aws:iam::046241478227:user/yongbao@bianjie.ai
      username: yongbao@bianjie.ai
    - groups:
      - ops
      userarn: arn:aws:iam::046241478227:user/congwen@bianjie.ai
      username: congwen@bianjie.ai

# 自定义权限
# 将 roles/clusterroles  绑定到用户
  mapUsers: |
    - userarn: arn:aws:iam::046241478227:user/yongbao@bianjie.ai
      username: yongbao@bianjie.ai

# aws-auth 的作用实际上是把 aws 的 IAM 用户传入到 kubernetes ,然后通过 rbac 方式进行授权
# aws 推荐使用角色而不是具体用户来绑定 kubernetes 的 group
# 但是通过我实际操作(ks8 group 绑定 aws 角色，然后 aws 角色 绑定 aws 用户)没有走通（20230501）
# 简单点还是直接通过 mapUsers 就好，可以以 user/group 为单位进行赋权
```

4、如果是自定义权限，将上面指定的 group/user，通过 rbac 绑定对应的 roles/clusterroles 就可以了

```
# 类似这样
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: ns-admin
  namespace: spark
rules:
- apiGroups: ["", "extensions", "apps", "networking.k8s.io"]
  resources: ["*"]
  verbs: ["*"]
---
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: ns-admin
  namespace: spark
subjects: 
- kind: User
  name: congwen@bianjie.ai
  apiGroup: ""
roleRef:
 kind: Role
 name: ns-admin
 apiGroup: ""
```



### 参考

https://docs.aws.amazon.com/zh_cn/eks/latest/userguide/add-user-role.html



### 节点组

指定节点删除并自动缩减节点组大小

```
aws autoscaling terminate-instance-in-auto-scaling-group --instance-id i-0dc647f4243015e05 --should-decrement-desired-capacity
```

