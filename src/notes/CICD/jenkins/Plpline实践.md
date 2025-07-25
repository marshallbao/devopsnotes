# Pipline 实践



代码拉取

```
# 方法1 默认会拉取 master，此时如果你的主分支是 main 分支可能会报错，可以使用方法2
# 方法1
git url: env.GITREPO, credentialsId: env.GITREPO_CREDENTIALS
sh "git checkout ${env.gitCommit}"

# 方法2
git branch: 'main', credentialsId: env.GITREPO_CREDENTIALS, url: env.GITREPO 
sh "git checkout ${env.gitCommit}"
```



script

```
# Jenkins Pipeline 中的 shell 命令无法直接引用 Groovy 脚本中的变量，你需要使用 ${} 语法来引用

script {
	sh "cat .env"
	// 如果 Params 变量有换行和空格的话，要使用单引号，'${Params}' ，防止有问题
	sh "echo '${evn.Params}' > .env"
	sh "cat .env"
}
# script 默认的环境是 Groovy 语言环境

```

