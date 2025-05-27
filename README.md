### 环境初始化

```
mkdir vuepress-starter
cd vuepress-starter

git init
yarn init
```



### 安装 vuepress
```
yarn add -D vuepress@next
```



### 安装打包工具和主题
```
yarn add -D @vuepress/bundler-vite@next @vuepress/vuepress-theme-hope@next
```



### 测试/构建/部署

```
# 开发测试
pnpm  docs:clean-dev

# 构建出静态资源
pnpm docs:build
```

