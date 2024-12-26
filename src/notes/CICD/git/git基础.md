git结构

​	工作区（写代码）
​	暂存区（临时存储）
​	本地库（历史版本）

​	工作区->git add ->暂存区->git commit->本地库（有新文件）
​    工作区->git commit->本地库（无新文件）
远程仓库<->本地仓库
​	远程库—>clone->本地库->push->远程库->pull->本地库

git clone:clone是将一个库复制到你的本地，是一个本地从无到有的过程
git pull:pull先从远程下载git项目里的文件，然后将文件与本地的分支进行merge。

git pull = git fetch + git merge

A远程仓库<->B远程仓库

​	A远程仓库->fork->B远程仓库->clone->本地仓库->push->B远程仓库->pull request->审核->merge->A远程仓库
​	
本地库初始化
​	git init
设置签名
​	用户名：
​	Email：
​	
​	项目级别>系统用户级别
​	项目级别
​	git config user.name tom_pro
​	git config user.email kubernetes_pro@163.com
​	系统用户级别
​	git config -global user.name tom_glb
​	git config --global user.email kubernetes_glb@163.com
​	
操作
​    正常操作
​	$ git status #查看工作区和暂存区的状态
​	$ git add hello.txt   #将工作区文区提交到暂存区
​	$ git rm --cached hello.txt  #从暂存区删除（不影响工作区文件）
​	$ git commit -m "My second commit for hello.exe" hello.txt  #将暂存区提交到本地仓库
​	
​	$ git log #查看提交日志
​	$ git log --pretty=oneline
​	$ git log --oneline
​	$ git reflog
​	撤销
​	只是修改了工作区
​	git restore  <file>
​	已经add到了缓存区
​	git restore --staged <file>
​	已经commit到了本地仓库
​	git reset hash
​	执行命令后会将本次提交的内容全部放置工作区供编辑；
​	
​	前进后退
​	基于索引值【推荐】
​	--hard！！！！慎用,使用hard模式，会使此次hash之后所有的内容都会没有，包括本地、远程！！！！！
​	$ git reset --hard dbdc027

​	使用^：只能往后推退
​	$ git reset --hard HEAD^^  #几个^往后退几步
​	使用~：只能往后推退
​	$ git reset --hard HEAD~3  #往后回退3步
​	
​	git reset soft:仅仅修改本地库
​	git reset mixed:修改本地库，重置暂存区
​	git reset hard:3个区域都修改
​	
​	找回删除的文件(已经上传至本地版本库了)
​	$ cat testrm  #编辑文件
​	$ git add testrm #上传次至缓存区
​	$ git commit -m "The first commit for testrm" testrm  #提交至本地版本库
​	$ rm testrm  #删除工作区文件
​	$ git add testrm  ##上传次至缓存区
​	$ git commit -m "delete testrm" testrm   #提交至本地版本库，这时版本库里有删除记录了
​	$ git reset --hard 61b133d #回到添加这个文件的版本，工作区，缓存区，本地版本库就都有testrm了
​	找回删除的文件（已经上传至缓存区了）
​	$ git reset --hard HEAD #因为删除文件的操作没有上传至本地库，所以直接更新为有这个文件最新的head即可；
​	前提：删除前，文件存在的状态已经提交到本地库了
​	操作：git reset --hard #指向文件操作的版本；
​	diff
​	$ git diff testrm     #将工作区与缓存区文件进行比较
​	$ git diff HEAD^ testrm  #将工作与本地库某个版本进行比较
​	$ git diff   #所有文件进行比较
​	
分支：
​	在版本控制过程中，使用多条线同时推进多个任务；
​	并行推进多个供能开发，提高开发效率
​	如果分支失败了，不会影响其他分支及master，删除重来就好
​	【分支操作】
​	$ git branch -v    #查看分支
​	$ git branch hot_fix    #新增分支
​	$ git checkout hot_fix   #切换分支
​	分支合并至master
​		1、切换至master $ git checkout master
​		2、合并： $ git merge hot_fix
​	合并冲突
​		1、$ vim hello.txt            #编辑冲突的文件，修改到你想要的状态（需要删除特殊符号）
​		2、$ git add hello.txt			#添加至缓存区
​		3、$ git commit -m "resolve confilict"  #提交至版本库（不要带有文件名）

【原理】
	1、cherrytree图
【远程仓库】
	1、push
	新建一个本地库 git init （test_git）
	$ git remote -v   #查看已经保存的远程库
	$ git remote add testgit https://gitee.com/marshallbao/test_git.git  #为远程库添加别名
	$ git push testgit master  #将本地库推送至远程库
	2、clone
	$ git clone https://gitee.com/marshallbao/test_git.git
		可以把完整的远程库下载到本地（创建一个文件夹）
		创建远程地址别名
		初始化本地库
	3、other pull 配置（这个地方有点问题）
	4、owner pull(pull = fetch + merge)
		$ git fetch testgit master #将远程库拉取下来（现在就是2个分支了）
		$ git checkout testgit/master  #切换到远程库
		$ cat README.md #就可以看到other上传的东西了
		$ git checkout master #切回master
		$ git merge testgit/master  #将远程库分支合并到master上
	5、解决协作冲突
		如果不是基于远程库最新版本所作的修改，不能推送，必须先拉去最新版本；
		拉取下来后进入冲突状态，则按照“分支冲突解决”
【跨团队协作】
 owner，other
 1、other fork owner的远程仓库
 2、other 将fork好的远程仓库 clone到本地
 3、other修改并commit至本地仓库
 4、other push 至自己的远程仓库
 5、通过自己的远程仓库创建pull request
 6、owner接收到other的pull request,进行审查
 7、通过后merge至自己的master
 8、owner pull 自己的master至本地仓库就可以看到了other做的操作了；

【配置ssh免密】
 1、生成公钥
 2、将公钥穿至远程库
 3、添加ssh remote
 4、push

【git工作流】
集中式
GitFlow
Forking
【gitlab】



### 参考

https://zhuanlan.zhihu.com/p/40001702
https://www.liaoxuefeng.com/wiki/896043488029600/897271968352576

​	

​	



​	
​	
​		