# DevOpsNote

## 环境初始化

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

## 测试/构建

```shell
# 开发测试
pnpm  docs:clean-dev

# 构建出静态资源
pnpm docs:build
```

## 部署
