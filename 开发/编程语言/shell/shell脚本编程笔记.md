         相关命令：
echo 
printf(echo的加强版)
I/O管道|及重定向><
（基本）正则表达
（扩展）正则表达
特殊字符
sed
cut
    cut 的语法: cut -d ‘:’ -f 2,3  #-f指定分隔符，-f选中哪一列
                     cut -c 字符区间 file   #字符区间就是指第几个字符，3,4.5-9
                     
join
awk（从最左边开始,扩展至最长，这个规则适用于sed,awk等其他）
    NR 行数
    NF 列数
    FS 列与列之间得分隔符
    RS 行与行之间得分隔符
排序sort
    -u:去掉重复得行   
uniq
fmt
wc
    -c(字节数),-l(行数),-w(字数);
head
tail
    head -n 5 /etc/passwd | tail -n 3
    