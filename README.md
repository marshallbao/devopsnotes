# DevOpsNotes - 个人运维笔记

## 📖 项目介绍

这是一个使用 [VuePress](https://vuepress.vuejs.org/zh/) 和 [VuePress Theme Hope](https://theme-hope.vuejs.press/zh/) 主题构建的个人技术笔记网站。主要记录运维、DevOps、容器化、中间件、数据库等相关技术内容。

## 🚀 快速开始

### 环境初始化

```shell
# 创建目录
mkdir vuepress-starter
cd vuepress-starter

# 初始化 git 和 yarn
git init
yarn init

#安装 vuepress
yarn add -D vuepress@next

# 安装打包工具和主题
yarn add -D @vuepress/bundler-vite@next @vuepress/vuepress-theme-hope@next
```

### 测试/构建

```shell
# 开发测试
pnpm  docs:clean-dev

# 构建出静态资源
pnpm docs:build
```

### 部署


## 📁 项目结构

```
devopsnotes/
├── src/
│   ├── .vuepress/
│   │   ├── config.ts          # VuePress 配置文件
│   │   ├── theme.ts           # 主题配置文件
│   │   └── styles/            # 样式文件
│   ├── notes/                 # 笔记内容
│   │   ├── AI/               # AI 相关笔记
│   │   ├── CICD/             # CI/CD 相关笔记
│   │   ├── DB/               # 数据库相关笔记
│   │   ├── Linux/            # Linux 相关笔记
│   │   ├── 容器/             # 容器化相关笔记
│   │   └── ...               # 其他分类
│   └── home.md               # 首页
├── package.json
├── pnpm-lock.yaml
└── README.md
```

## 🔗 相关链接

### 官方文档

- [VuePress 官方文档](https://vuepress.vuejs.org)
- [VuePress Theme Hope 官方文档](https://theme-hope.vuejs.press)