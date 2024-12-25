​         AWK 是一种解释执行的编程语言。它非常的强大，被设计用来专门处理文本数据

读（Read） AWK 从输入流（文件、管道或者标准输入）中读入一行然后将其存入内存中。 
执行(Execute) 对于每一行输入，所有的 AWK 命令按顺执行。 默认情况下，AWK 命令是针对于每一行输入，但是我们可以将 其限制在指定的模式中。
重复（Repeate） 一直重复上述两个过程直到文件结束。

程序的结构 我们已经见过 AWK 程序的工作流程。 现在让我们一起来学习 AWK 程序的结构。
开始块（BEGIN block） 开始块的语法格式如下所示： BEGIN {awk-commands}
主体块（Body Block） 主体部分的语法要求如下： /pattern/ {awk-commands}
结束块（END Block） 下面是结束块的语法格式： END {awk-commands}

AWK 命令行 如下所示，在命令行中，我们可以使用如下的格式调用 AWK 命令，其中 AWK 命令由单引号括起来： 
awk [options] file 

AWK 程序文件 接下来讲解的是另外一种提供 AWK 命令的方式——通过脚本文件提供： 
awk [option] -f file ....

awk '/a/ {print $0}' marks.txt #通过匹配模式串输出列，所有带a的行，所有列
awk '/a/ {print $3 "\t" $4}' marks.txt #通过匹配模式串输出列，把带a的行，输出第3，4列
awk '/a/{++cnt} END {print "Count = ", cnt}' marks.txt  #计数
awk 'length($0) > 18 {print $1}' marks.txt #匹配整行字符数大于18的行，然后输出第一列

变量
ARGC 表示在命令行提供的参数的个数。
FILENAME此变量表示当前文件名称。
awk 'END {print FILENAME}' marks.txt    #输出文件的名字
FS 此变量表示输入的数据域之间的分隔符，其默认值是空格。使用 -F 命令行选项改变它的默认值
awk -F “s” ‘{print $2}’   #使用s作为分割符
NF 此变量表示当前输入记录中域的数量,(就是列的数量)
free -h |grep Mem:|awk ‘{print NF}’ #输出列的数量
free -h |awk ‘NF>5’ #输出列大于5的所有信息
free -h |awk ‘NF>5{print $2}’
NR 此变量表示当前记录的数量
free -h |awk ‘NR<2’   #输出第一行
free -h |awk ‘NR<2 {print $2}’   #输出第一行，第2列
OFS 此变量表示输出域之间的分割符，其默认为空格。
ORS 此变量表示输出记录（行）之间的分割符，其默认值是换行符。