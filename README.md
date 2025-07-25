# DevOpsNotes - 个人运维笔记

[![VuePress](https://img.shields.io/badge/VuePress-2.0.0--rc.19-brightgreen.svg)](https://v2.vuepress.vuejs.org/)
[![VuePress Theme Hope](https://img.shields.io/badge/VuePress%20Theme%20Hope-2.0.0--rc.66-blue.svg)](https://theme-hope.vuejs.press/)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

> 基于 VuePress 2 和 VuePress Theme Hope 主题构建的个人运维技术笔记网站

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

- [VuePress 2 官方文档](https://v2.vuepress.vuejs.org/)
- [VuePress Theme Hope 官方文档](https://theme-hope.vuejs.press/)
- [Vue 3 官方文档](https://vuejs.org/)
- [Vite 官方文档](https://vitejs.dev/)

## 📄 许可证

本项目采用 [MIT 许可证](LICENSE)。