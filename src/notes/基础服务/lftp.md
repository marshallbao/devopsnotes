## lftp 简介



lftp是个功能强大的字符界面文档传输工具，它包含以下功能：
• 支持ftp、ftps、http、https、hftp、fish等传输协议
• 支持FXP
• 支持代理
• 支持多线程传输
• 支持书签
• 类似bash，提供后台命令、nohop模式、命令历史、命令别名、命令补齐等进程管理功能





## 登录 ftp服务器



使用以下命令登录 ftp服务器：
lftp ftp://用户名[:密码]@服务器地址[:端口] #标准方式，推荐
lftp 用户名[:密码]@服务器地址[:端口]
lftp 服务器地址 [-p 端口] -u 用户名[,密码]
lftp 服务器地址[:端口] -u 用户名[,密码]   • 如果不指定端口，默认 `21`
• 如果不在命令中使用明文输入密码，连接时会询问密码(推荐)

可以使用“书签”收藏服务器站点，在 lftp 中以下命令，为当前站点定义别名：
lftp >bookmark           #显示所有收藏
lftp >bookmark add 别名  #使用 `别名` 收藏当前站点 使用别名登录 ftp服务器：
lftp 别名  也可以编辑 lftp 的配置文件 `~/.lftp/bookmarks` ，格式如下:
别名 ftp://用户名:密码@服务器地址:端口  



## lftp 使用方法



大多数图形界面的 ftp客户端，都有两栏窗口，一栏为本地目录，一栏为远程目录。lftp 也采用这种方式工作，只不过没有使用图形界面直观的显示

| 命令         | 本地   | 远程 |
| ------------ | ------ | ---- |
| 显示工作目录 | lpwd   | pwd  |
| 切换目录     | lcd    | cd   |
| 显示文件列表 | !ls    | cls  |
|              | !ls -l | ls   |


• 其中， `!` 表示执行本地命令，lftp中没有与 ls 对应的本地命令 lls， 所以要使用 !ls 显示本地目录文件
使用以上命令确认当前工作目录的情况。以下命令用于从本地目录上传，或者从远程目录下载：

|          | 下载   | 上传      |
| -------- | ------ | --------- |
| 单个文件 | get    | put       |
| 多个文件 | mget   | mput      |
| 多线程   | pget   |           |
| 目录     | mirror | mirror -R |


• 在 lftp 配置文件 `~/.lftp/rc` 中设置 pget 使用的线程数
set pget:default-n 5   
在远程目录中，可以使用以下命令操作文件

| 点击这里     | 点击这里 |
| ------------ | -------- |
| 统计文件大小 | du       |
| 移动、重命名 | mv       |
| 删除         | rm       |
| 创建文件夹   | mkdir    |
| 删除文件夹   | rmdir    |



使用 `exit` 命令退出 lftp



## 中文乱码



大多数 windows 平台下的 ftp服务器 使用 GB2312 编码，而 lftp 使用 UTF-8 编码，使用 lftp 访问这些服务器，中文显示为乱码。可以通过指定编码来解决
lftp >set ftp:charset gbk   #设置远程编码为gbk
lftp >set file:charset utf8 #设置本地编码(Linux系统默认使用 UTF-8，这一步通常可以省略)  也可以在 lftp 配置文件中 `~/.lftp/rc` 设置默认值：
set ftp:charset gbk
set file:charset utf8 




lftp下载文件无法覆盖，提示" file already existst and xfer:clobber is unset" 问题解决
原创shouldsimple 最后发布于2011-11-30 15:06:57 阅读数 2828  收藏
展开
在.lftprc文件中添加以下配置即可

set xfer:clobber on