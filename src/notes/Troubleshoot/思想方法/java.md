1、java服务CPU内存使用率持续较高

​    1、找到CPU利用率持续比较高的进程，获取进程号：
​        top -c
​    2、找到上述进程中，CPU/内存利用率比较高的线程号TID（十进制数）：
​        ps p PID -L -o pcpu,pmem,pid,tid,time,tname,cmd
​        或
​        ps -mp PID -o THREAD,tid,time,rss,size,%mem
​        或
​        top -Hp pid         #找到占用高线程的tid号
​    3、查看内存使用的堆栈：
​        将获取的线程号（十进制数）转换成十六进制的nid号：
​        printf "%x\n" TID     #此命令将TID号转换成对应的十六进制nid号
​    4、根据TID对应的PID号执行jstack命令打印堆栈信息
​        jstack -l PID 
​        或
​        jstack -l PID >> jstack.log