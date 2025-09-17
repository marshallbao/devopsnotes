# GitCommit 最佳实践

### 关于语义化提交

语义化提交（Semantic Commit）指的是：

 **通过统一的 commit message 格式，把提交的“意图”表达清晰，从而让人和机器都能读懂。**

它最常见的实现就是 **Conventional Commits 规范**：

```
<type>(<scope>): <subject>

[body]
[footer]
```

#### 组成部分

**type**（必填）
 提交的类型，常见有：

- `feat` → 新功能（feature）
- `fix` → 修复 bug
- `docs` → 文档变更
- `style` → 代码格式（不影响逻辑）
- `refactor` → 重构（既不是新功能也不是修复 bug）
- `perf` → 性能优化
- `test` → 测试相关变更
- `chore` → 杂项（构建流程、依赖升级、配置修改等）



**scope**（可选）
 变更影响的范围，比如：

- 模块名：`auth` / `payment` / `ui`
- 服务名 + 环境：`gateway/prod`



**subject**（必填）
 简洁明了的描述本次提交（一句话，不超过 50 字符）。



**body**（可选）
 详细说明“做了什么”、“为什么做”。



**footer**（可选）
 一般用于：

- 关联 issue/ticket：`Closes #123`
- 重大变更标记：`BREAKING CHANGE: ...`



### 关于 helm/yaml 的文件仓库

```
# 推荐格式
<type>(<scope>): <subject>

# type，主要是前三种
feat：功能性变更（如增加一个新服务部署、常规发布、新增 cm/svc/secret 等）
fix：修复配置问题（如改错了副本数、资源限制、注解等和服务相关的）
chore：杂项（如格式化 YAML 、整理文件等和业务服务无关的）
ci：CI/CD 自动生成的提交（如更新镜像 tag）
revert：回滚提交

# scope（范围）
环境/集群/项目/namespace/服务等

# subject（一句话说明）
简洁清晰，最好包含 变更点 和 结果


# 示例
feat(prod/vena): add new service -> message-server
fix(prod/vena/wallet-server): upate cm -> log_level from info to debug
chore(prod/vena/wallet-server): fix format
```

