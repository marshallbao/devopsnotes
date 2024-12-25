#### 关于本地分支和远程分支

远程分支的3种状态

- 远程仓库确实存在分支dev
- 本地版本库（.git）中的远程快照
- 和远程分支建立联系的本地分支



#### 关于本地仓库和远程仓库



#### git pull 和git fetch 的区别

git 文件夹里面存储了 git 本地仓库所有分支的 commit ID 和跟踪的所有远程分支的 commit ID，分别存储在

.git/refs/remotes/origin/ 和 .git/refs/heads/ 下

通俗来说是 git pull = git fetch + git merge

以 ops 分支为例

**git fetch**

将远程 dev 分支的 commit ID 拉取至 .git/refs/remotes/origin/ops 文件下

**git merge**

将存储在 .git/refs/remotes/origin/ops 文件下的远程 dev 分支的 commit ID 和存储在 

.git/refs/heads/ops 文件下的本地 dev 分支的 commit ID 进行合并

**git pull** 

将远程分支的 commit ID 拉取至 .git/refs/remotes/origin/ops 文件下并和存储在 

.git/refs/heads/dev 文件下的本地 ops  分支的 commit ID 进行合并

总结

实际上不管 git pull 还是 git fetch + git merge，在有冲突的情况下，都需要手动解决冲突；

同理

在本地 ops 分支执行 commit 所产生的 commit ID只会存在于 .git/refs/heads/ops 文件下，而执行 push 操作之后 .git/refs/remotes/origin/ops 文件内的 commit ID 才会和本地的 commit ID 相同

