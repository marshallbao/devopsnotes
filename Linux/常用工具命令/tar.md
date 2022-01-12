​         
1、压缩、解压缩命令

zip<-->unzip
    后缀：.zip
    选项：-d 指定解压到哪个目录
    zip target.zip dir_or_file
    unzip pakage_name.zip    
    
gzip<-->gzip -d |gunzip
gzip:/PATH/to /SOMEFILE；压缩完成后会删除原文件
    后缀：.    
    选项：-c：将压缩的数据输出到屏幕上
              -d：解压缩的参数
              -t：检验压缩文件的正确性
              -#：压缩等级 1-9；指定压缩比，默认是6
     gzip install.log               源文件会自动删除

bzip2<-->bunzip2|bzip2 -d
    后缀：.bz2
    选项：-c：将压缩的数据输出到屏幕上
              -d：解压缩的参数
              -k:保留源文件
              -v:显示详细信息
              -#：1-9；默认是6
              
zcat:PATH/to/SOMEFILE.zp:不解压的情况，查看文本文件的内容

归档：
tar
    后缀；.tar
    选项：
    -c:新建打包文件    
    -v:将正在处理的文件名显示出来
    -x:解压缩解打包
    -t:查看打包文件的内容有哪些
    -j:通过bzip2压缩/解压的文件.tar.bz2
    -z:通过gzip压缩/解压的文件 .tar.gz
    -f:filename 接要被处理的文件
    -C:指定解压缩的目录

压缩格式：gz,bz2,xz,zip,

​	-zcf:归档并调用gzip压缩
​	-zxf:调用gzip解压缩并展开归档；z可省略(下同)
​	
​	-jcf：bzip2
​	-jxf：
​	
​	-Jcf；xz
​	-Jxf: