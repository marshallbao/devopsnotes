---
home: true
title: 首页
icon: home
heroImage: /logo.png
heroImageDark: /logo-dark.png
heroImageStyle: "width: 200px; height: 200px;"

heroText: DevOpsNotes
tagline: 个人运维技术笔记与经验分享

actions:
  - text: 开始阅读
    link: /notes/
    type: primary
  - text: 关于我
    link: /person/
    type: secondary

features:
  - title: 🚀 DevOps 实践
    details: 持续集成/持续部署、自动化运维、容器化部署等实践经验
    link: /notes/CICD/
    icon: rocket

  - title: 🐳 容器技术
    details: Docker、Kubernetes、容器编排、微服务架构等
    link: /notes/容器/
    icon: docker

  - title: 🐧 Linux 运维
    details: 系统管理、性能优化、网络配置、安全加固等
    link: /notes/Linux/
    icon: linux

  - title: 🗄️ 数据库管理
    details: MySQL、PostgreSQL、Redis、MongoDB 等数据库运维
    link: /notes/DB/
    icon: database

  - title: 🔧 中间件运维
    details: Kafka、RabbitMQ、ZooKeeper、Tomcat 等中间件
    link: /notes/中间件/
    icon: tools

  - title: 🔒 安全运维
    details: 安全配置、证书管理、访问控制、安全审计等
    link: /notes/安全/
    icon: shield

footer: false
---

## 🎯 网站介绍

这是一个专注于 **DevOps** 和 **运维技术** 的个人笔记网站，记录我在实际工作中的技术实践和经验总结。

### 📚 内容涵盖
- **DevOps 工程**: CI/CD 流水线、自动化部署、基础设施即代码
- **容器技术**: Docker、Kubernetes、服务网格、微服务架构
- **系统运维**: Linux 系统管理、性能优化、网络配置
- **数据管理**: 数据库运维、高可用架构、备份恢复
- **中间件**: 消息队列、缓存、应用服务器
- **安全运维**: 安全加固、证书管理、访问控制

---

## 🔗 快速导航

<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">

### 🚀 运维实践
- [CI/CD 流水线](/notes/CICD/)
- [容器化部署](/notes/容器/)
- [自动化运维](/notes/CICD/ansible/)

### 🛠️ 技术栈
- [Linux 系统管理](/notes/Linux/)
- [数据库运维](/notes/DB/)
- [中间件管理](/notes/中间件/)

### 🔒 安全运维
- [安全配置](/notes/安全/)
- [证书管理](/notes/安全/证书/)
- [访问控制](/notes/安全/认证和授权/)

</div>

---

## 📊 网站统计

<div class="grid grid-cols-2 md:grid-cols-4 gap-4 text-center">

<div class="stat-item">
  <div class="stat-number">100+</div>
  <div class="stat-label">技术文章</div>
</div>

<div class="stat-item">
  <div class="stat-number">50+</div>
  <div class="stat-label">实践案例</div>
</div>

<div class="stat-item">
  <div class="stat-number">10+</div>
  <div class="stat-label">技术分类</div>
</div>

<div class="stat-item">
  <div class="stat-number">5+</div>
  <div class="stat-label">年经验</div>
</div>

</div>

---

## 📚 最新内容

<AutoCatalog />

<style>
.stat-item {
  padding: 1rem;
  border-radius: 8px;
  background: var(--vp-c-bg-soft);
  border: 1px solid var(--vp-c-divider);
  transition: all 0.3s ease;
}

.stat-item:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.stat-number {
  font-size: 2rem;
  font-weight: bold;
  color: var(--vp-c-brand);
}

.stat-label {
  font-size: 0.9rem;
  color: var(--vp-c-text-2);
  margin-top: 0.5rem;
}

.grid {
  display: grid;
  gap: 1rem;
}

.grid-cols-1 {
  grid-template-columns: repeat(1, minmax(0, 1fr));
}

@media (min-width: 768px) {
  .grid-cols-2 {
    grid-template-columns: repeat(2, minmax(0, 1fr));
  }
  
  .md\\:grid-cols-2 {
    grid-template-columns: repeat(2, minmax(0, 1fr));
  }
  
  .md\\:grid-cols-4 {
    grid-template-columns: repeat(4, minmax(0, 1fr));
  }
}

@media (min-width: 1024px) {
  .lg\\:grid-cols-3 {
    grid-template-columns: repeat(3, minmax(0, 1fr));
  }
}
</style> 