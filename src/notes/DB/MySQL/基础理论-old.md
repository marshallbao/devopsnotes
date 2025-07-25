# 关系型数据库基础

MySQL
SQL/MySQL
事务，隔离，并发控制，锁
用户和权限
监控
​	STATUS
索引类型：查询
​	VARIABLES
备份和恢复
复制功能
集群


文件
	数据冗余和不一致性
	数据访问困难
	数据孤立
	完整性问题
	原子性问题
	并发访问异常
	安全性问题

文件
	表示层
		文件
	逻辑层
		文件系统：存储引擎
	物理层
		元数据
		数据：数据块
	

DBMS
	层次模型
	网状模型
	关系模型
RDBMS

E-R：实体-关系模型
关系模型：（结构化数据模型）
	关系模型
	实体-关系模型
	对象关系模型：基于对象的数据模型
	半结构化数据模型：SML(扩展标记语言)
		<name>Jerry</name>
		<age>25</age>
		gender:
		
		name:
		uid:
		birthdate：
		
		name:age:gender
		name:uid:birthdate

关系：代数运算
	交集：
	并集：
	差集：
	补集：

SQL：Structured Query Language
	


1970年
System R :SQL 
	
Ingres,	Oracle,Sybase

ANSI:ansi-sql

DML:数据操作语言（增删查改）
	INSERT
	DELETE
	SELECT
	UPDATE
DDL：数据定义语言
	CREATE
	DROP
	ALTER
	
DCL:数据控制语言
	GRANT
	REVOKE
	
访问权限
	
	
RDB对象：
	库，表，索引，视图，用户，存储过程，存储函数，触发器，事件调度器
	约束
		域约束：数据类型约束
		外键约束：引用完整性约束
		主键约束：某字段能唯一标识此字段所属实体，并且不允许为空
			一个表只能有一个主键
		唯一性约束：每一行的某字段都不允许出现相同值，可以为空
			一张表中可以有多个
		检查性约束：age:int
	
	constraint

关系型数据库

表示层；表
逻辑层：存储引擎
物理层：数据文件	

数据存储和查询：
	存储管理器：
			权限及完整性管理
			事务管理器
			文件管理器
			缓冲区管理器
	查询管理器：
		DML解释器
		DDL解释器
		查询执行引擎
	
		
单进程
	多进程
		守护线程
		应用线程
			10个用户
	32bit
		2.7G
	64bit
		smp:对称多处理器
	
thread reuse:线程复用	

关系运算：
	投影：只输出特定属性
	选择：只输出符合条件的行
	自然连接：具有相同名字的属性上所有取值相同的行
	笛卡尔积：
		（a+b）*（c+d）=ac+ad+bc+bd
	并：集合运算



\---------------------------------------------------
32_02_mysql系列之二关系型数据库基础理论-2019.1.15	
	
SQL查询语句：
		sequel-->SQL 
			SQL-86
			SQL-89
			SQL-92
			SQL-99
			SQL-03
			SQL-08

SQL 语言的组成部分：
	DDL
	DML
	完整性定义语言：DDL的一部分功能
	视图定义:
	事务控制：
	嵌入式SQL和动态SQL：
	授权：DCL
	
使用程序设计语言如何跟RDBMS交互：
	嵌入式SQL：与动态SQL类似，但其语言必须在程序编译时完全确定下来；
		ODBC
	动态SQL：程序设计语言使用函数（mysql_connect()）或者方法与RDBMS服务器建立连接，并进行交互；通过建立连接向SQL服务器发送查询语句，并将结果保存至变量中而后进行处理；
		JDBC
	
查询逻辑：	
	1	连接管理器
	 （2,3）缓存    2 解析器
		3优化器
		4存储引擎
	
MySQL 支持插件式存储引擎
5.5.8（默认）之前：MyISAM-不支持事务
	（默认）之后：InnoDB-支持事务
	
	
	
用户请求  -->连接管理器    
线程管理器 
  用户模块（检测用户是否有权限）	
  缓存<-- 命令分发模块（检查缓存，生成日志）-->日志模块
	解析器 （解析查询，并生成解析数）
优化器   表定义模块    表维护模块     复制模块     状态报告模块  
	访问控制模块
	表管理器
	存储引擎
	
	
	
表管理器：负责创建、读取或修改表定义文件；维护表描述符高速缓存；管理表锁；
		表结构定义文件
	
表修改模块：负责创建、删除、重命名、移除、更新或插入之类的操作；
表定义模块：检查、修改、备份、恢复、优化（碎片整理）及解析；	
	
行：定长，变长

文件中记录组织：
		堆文件组织：一条记录可以放在文件中的任何地方；
		顺序文件组织：根据“搜索码”值顺序存放；
		散列文件组织：
	
表结构定义文件，表数据文件

表空间：table space
	
数据字典：Data Dictionary 
		关系的元数据：
			关系的名字
			字段名字
			字段的类型与长度
			视图
			约束
			
			用户名字，授权，密码

缓冲区管理器：
	缓存置换策略
	被钉住的块
	
访问路径的选择性：一个访问路径的选择性是所有获取的页面数（如果使用这个访问路径去获取所有想要的元组）。如果一个表包含一个与给定条件相匹配的索引，就至少存在两条访问了路径：使用索引和扫描整个数据文件
最有选择性的路径是检索最少页数的路径：使用最有选择性的路径将使用获取数据的代价降到最小，而一个访问路径的选择性依赖于选择条件中的主合取体（与涉及的索引有关），每个合取体就好比表上的一个过滤器，满足一个给定合取的元组在表中所占的百分比成为缩减因子。
		
	
\--------------------------------------------------------
32_03_mysql系列之三MySQL数据库基础及编译安装-2019.1.17

MySQL安装：
		专用软件包管理器
			deb,rpm
			rpm:
				RHEL(Oracle Linux),CentOS
				SUSE
		通用二进制格式包
			fcc:x86,x64
		源代码
			5.5 5.6
				cmake
	
	
MySQL用户密码修改：	
	1、mysqladmin -u USERNAME -h HOSTNAME password 'NEW_PASS' -P	
	2、mysql>SET PASSWORD FOR 'USERNAME'@'HOST'=PASSWORD('new_pass');
	3、mysql>UPDATE mysql.user SET PASSWORD=PASSWORD('new_pass')WHERE CONDITION;
	
MySQL安装：	
	源码安装MySQL
		cmake
	
	
字符集：
		人：00101010 10101010
		人：10101010 01010101
	
	汉字：字符集
		GBK
		GB2312
		GB18030
		UTF8

排序规则
	
性能分析
	
MySQL客户端工具：
	mysql
	mysqldump
	mysqladmin
	mysqlcheck
	mysqlimport
		
	[client]
	-u USERNAME
	-h HOST
	-P ''
	--protocol {tcp|socket|pipe|memory}


​	
​	
​	
​	show databases;
​	show engines;

MySQL非客户端工具：
		myisamchk
		myisampack
	
MuISAM:
	每表三个文件：
		.frm:表结构
		.MYD:表数据
		.MYI:表索引
	
InnoDB:
	所有表共享一个表空间文件；
	建议：每表一个独立的表空间文件；
		配置文件修改参数如下：
			innodb_file_per_table = on/1
	
mysql>mysqld 
	--user, -u
	--host, -h
	--password,-p
	--port
	--protocol
	--database DATABASE,-D

mysql>
	交互式模式
		批处理模式（脚本模式）
			mysql < init.sql
			mysql>\. /tmp/test.sql
	
mysql>	
	命令两类：
		客户端命令
		服务器语句：有语句结束符，默认；
		\d：定义语句结束符
		//
	
	客户端命令：
		\c：提前终止语句执行
		\g：

mysql>
	->
	'>
	">
	`>
	
补全：
	名称补全
	rehash?
	
输出格式：	
	
服务器端命令获取帮助：
	help COMMAND
	
	
\#musqladmin [option] command [arg] [command[arg]]...
\#mysqladmin -uroot -p password 'NEW_PASS'

​	crete DATABASE
​	drop database
​	ping
​	processlist
​	status
​		--sleep N :显示频率
​		--count N：显示多个状态
​	extended-status:显示状态变量
​	variables: 显示服务器变量
​	flush-privileges:让mysql重读授权表
​	flush-status:重置大多数服务器状态变量
​	flush-logs:二进制和中继日志滚动
​	flush-hosts：
​	refresh :相当于同时执行flush-hosts和flush-logs
​	shutdown:关闭mysqld服务器进程
​	version:服务器版本及当前状态
​	
​	start-slave:启动复制，启动从服务器复制线程
​		SQL thread
​		IN thread
​	stop-slave:关闭复制

mysqldump,mysqlimport,
	
	
开发视角：
		数据类型
		约束
		数据库、表、索引、视图
		SELECT
	
	
\------------------------------------------------------
33_01_MySQL系列之五——MySQL数据类型及sql模型-2019.02.24

插入式存储引擎

存储引擎，也称为表类型：

MyISAM表：无事务，表锁
	.frm:表结构定义文件
	.MYD:表数据
	.MYI:索引

InnoDB表：事务，行锁
	.frm:表结构
	.ibd:表空间（数据和索引）
	
MySQL:mysql:MyISAM

查看默认存储引擎：
	show engines;
	
查看表属性：
	show table status;
	
	show table status like 'test'\G;


程序语言链接数据库的方式：
	动态SQL：通过函数或方法与数据库建立连接
	嵌入式 SQL:
	
	JDBC,ODBC

客户端：mysql,mysqladmin,mysqldump,mysqlimport,mysqlcheck

服务器：mysql,mysqld_safe,mysqld_multi


my.cnf

/etc/my,cnf --> /etc/mysql/my.cnf --> $MYSQL_HOME/my.cnf --> --default-extra-file=/path/to/somefile --> ~\.my.cnf

[mysqld]

[mysql_safe]

[client]
host=

[mysql]
\# mysql --help --verbose


datadir=/mydata/data

hostname.err:错误日志

1、此前服务未关闭
2、数据初始化失败
3、数据目录位置错误
4、数据目录权限问题

DBA：
	开发DBA；数据库设计，SQL语句、存储过程、存储函数、触发器
	管理DBA：安装、升级、备份、恢复、用户管理、权限管理、监控、性能分析、基准测试
		
数据类型：
	数值型
		精确数值
			int
		近似数值
			float
			double
			real
		字符型
			定长：CHAR(#),BINARY
			变长:VARCHAR(#),VARBINARY
			text,blob
		日期时间型
			date，time,datetime,timestamp
			
		
	>show character set;#显示支持的字符集
	>show collation; #显示支持的排序规则；
		
	auto_increment
		整型
		非空
		无符号
		主键或唯一键
		
	create table test(id int undingned auto_increment not null primary key,name char(20))
	
	mysql>select last_inser_id();


​		
​	dns
​	
	RRtype CHAR(4)
		A,PTR,CHAME,AAAA,MX,NS,SOA,SRV
	
	RRtype ENUM('A','PTR')

SQL模型：
	abc,abcdefg
	CHAR(3)
	
MySQL服务器变量：
	作用域，分为两类
		全局变量
			SHOW GLOBAL VARIABLES
			
		会话变量
			SHOW [SESSION] VARIABLES
	
	生效时间：分为两类：
		动态：可即时修改
		静态：
			写在配置文件中
			用过参数传递给mysqld
	
	动态调整参数的生效方式：
		全局：对当前会话无效，只对新建立会话有效；
		会话：即时生效，但只对当前会话有效
		
	服务器变量：@@变量名
		显示：select
		设定：set globle|session  变量名=‘value’

/etc/my.cnf

~/.my.cnf
	
	
	mysql>select @@global.sql_mode;
	mysql>show global variables;
	mysql>show variables;

MySQL管理表和索引

SQL语句：
	数据库
	表
	索引
	视图
	DML
	
数据库：
		CREATE DATABASE |SCHEMA [IF NOT EXISTS] db_name [CHARACTER SET = ] [COLLATE=]#定义默认字符集和排序规则
		
		例如：创建默认字符集为gbk，默认排序规则为gbk_chinese_ci的数据库 test1db
		SHOW CHARACTER SET;
		SHOW COLLATION ;
		CREATE SCHEMA IF NOT EXISTS test1db CHARACTER SET 'gbk' COLLATE 'gbk_chinese_ci';
		
		生成db.opt文件
			default-character-set=gbk
			default-collation=gbk_chinese_ci
			
		DROP {DATABASE |SCHEMA } [IF EXISTS] db_name

表：
		1、直接定义一张空表
		2、从其他表中查询数据、并以之创建新表
		3、以其他表为模板创建一个空表
		
    1.	CREATE TABLE [IF NOT EXISTS] tb_name (col_name col_defination,constraint)

​	例：
​	CREATE TABLE IF NOT EXISTS COURSES(CID TINYINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,COUSE VARCHAR(50) NOT NULL); 
​	SHOW TABLE STATUS LIKE 'courses';
​	SHOW TABLE STATUS LIKE 'courses'\G
​	
​	查看表索引：SHOW INDEXES FROM table_name;	
​	
​	2.根据已有的表查询出的数据创建表：CREATE TABLE testcourses SELECT * FROM courses WHERE CID <= 2;
​		
​	 根据已有的表创建新表：CREATE TABLE TEST LIKE courses;	
​		
​	修改表属性：
​		ALTER TABLE
​			添加、删除、修改字段
​			添加、删除、修改索引
​			改表名
​			修改表属性
​	
​	删除表：drop table  tb_name
​						
​		查看表结构：desc table_name;
​				Field     | Type                | Null | Key | Default | Extra          |
​		+-----------+---------------------+------+-----+---------+----------------+
​		| CID       | tinyint(3) unsigned | NO   | PRI | NULL    | auto_increment |
​		| Course    | varchar(50)         | NO   | UNI | NULL    |                |
​		| startdate | date                | NO   |     | NULL    |    
​		
​		更改表属性：alter table TEST change starttime startdate date not null ;# 选择表名，chang 字段 新字段 属性（不可省略的不能缺，如果缺会报错）；
​		
​		更改表名：alter table TEST RENAME TO test;#实际操作：要先导出数据，新建表（换名字），导入数据，检查无误，删除原表；
​		
​		新建表：create table student (sid int unsigned not null auto_increment primary key,name varchar(30),cid int not null);
​		
​		插入数据：insert into student (name,cid) values ('Yue Yunpeng',2),('Wang Dana',1);
​		
​		select name,Couse from student,courses where student.cid=courses.cid;
​		
​	InnoDB支持外键

​	索引创建：（只能创建和删除，不能修改）
​		create index index_name on tb_name (col,...);
​		col_name [(length)] [asc|desc]
​		
​		create index name_on_student on student (name (5) desc ) using btree;
​		
​		drop index name_on_student on  tb_name;
​		
​		
​		
​		
​	name
​	
​	11234
​	11567
​		
​		
​		
\-----------------------------------------------------------
33_03_MySQL系列之七——单表查询、多表查询和子查询-2019.02.24


DDL:

DML:
	SELECT
	INSERT INTO
	DELETE
	UPDATE

SELECT select-list from tb where qualification
查询语句类型：
	简单查询
	多表查询
	子查询
	
SELECT * FROM tb_name;

SELECT filed1,filed2 FROM tb_name;#投影

SELECT [DISTINCT]* FROM tb_name WHERE qualification;#选择
		
FROM子句：要查询的关系， 表，多个表，其它SELECT语句
WHERE子句：布尔关系表达式
	=,>,>=,<=,<
	逻辑关系：
		and
		or
		not
		
	between .... and ...
	like ''
		%:任意长度任意字符
		_:任意单个字符
		regexp,rlike
		in
		is null
		is not null

order by filed_name {asc|desc}

字段别名：as

limit字句：limit{offset,}count

聚合计算：sum(),min(),max(),avg(),count()

group by:分组
	having qualification

练习语句：
select name,age,gender from student where not age>20 and not gender='m';#多条件		

select name from student where name like 'y%';#like模糊取值		
		
select name from student where name rlike '^[xy].*$';#支持正则表达式	

select hostid,name from hosts where hostid in (10123,10111,10022);#离散取值

select name from student where cid2 is not null oeder by name desc;#空值，排序输出

select name as student_name from student ;#支持别名

select name as student_name from student limit 2；#前两个

select name as student_name from student limit 2,3;#偏移2个，只显示3个；

select avg(age) from student;

select count(cid1) as persons,cid1 from student group by cid1 having persons>=2;#直接引用别名


多表查询：
	连接：
		交叉连接：笛卡尔乘积
		自然连接：
		外连接：
			左外连接：...left join ... on ....
			右外连接：...right join ... on ....
			自连接：
			
子查询：			
	比较操作中使用子查询；子查询只能返回单个值；
	IN（）:使用子查询；




select * from student,courses where student.cid1 = courses.cid;

select student.name ,courses.cname from student,courses where student.cid1 = courses.cid;

select s.name,c.cname from student as s,courses as c where s.cid1=c.cid;#定义表别名；自然连接

select name from student where age > (select avg(age) from student);#子查询


















​	
​	
\-----------------------------------------------------
34_03_MySQL系列之十一——MySQL用户和权限管理2019.02.19	





六张表：
	user:用户账号、全局权限、其他
	db:数据库级别的权限定义；select * from db;
	host:废弃
	tables_priv:表级别权限
	columns_priv:列级别权限
	procs_priv:存储过程和存储函数相关的权限
	proxies_priv:代理用户权限


用户账号：
	用户名@主机
		用户名：16个字符以内
		主机：	
			主机名：byg7
			IP：172.168.56.103
			网络地址：172.168.0.0/255.255.0.0
		
			通配符:%,_
				172.168.%.%
				%.maedu.com
	--skip-name-resolve

权限级别：
	全局级别
	库
	表
	列
	存储过程与存储函数

字段级别：

临时表；内存表
	heap:16MB
	
触发器：主动数据库
	INSERT,SELETE,UPDATE
		user:log
		
创建用户：	
CREATE USER username@localhost [IDENTIFIED BY 'password']


授权：

GRANT

GRANT ALL PRIVILEGES ON [object_type]db.* TO username@'%';

TABLE 
	FUNCTION
	PROCEDURE

GRANT EXECUTE ON FUNCTION db.abc TO username@'%';



INSERT INTO mysql.user
mysql>FLUSH PRIVILEGES;

SHOW GRANTS FOR USER@HOST


with_option:
    GRANT OPTION
  | MAX_QUERIES_PER_HOUR count# count=0 #不再做限定了 
  | MAX_UPDATES_PER_HOUR count
  | MAX_CONNECTIONS_PER_HOUR count
  | MAX_USER_CONNECTIONS count


练习： 
grant create on testdb.* to 'test'@'%';

create table testtb (id int unsigned auto_increment not null ,name char(20),primary key (id));

insert into testtb (name) values ('Tom'); #没有给插入数据的权限；
grant insert on testdb.* to 'test'@'localhost';

show grants for 'test'@'localhost';

flush privileges;#与会话相关；

alter table testtb add age tinyint unsigned;#权限拒绝

grant alter on testdb.* to 'test'@'localhost';

flush privileges;

退出会话，重新连接；权限生效；

grant update(age) on testdb.testtb to 'test'@'localhost';
flush privileges;
update testtb set age=30 where id =1;


grant super on *.* to 'test'@'localhost';
flush privileges;
set global tx_isolation='read-uncommitted';

删除用户：

drop user 'username'@'host';

rename user old_name to ner_name;

收权：

show grants for 'test'@'localhost';#查看权限
revoke select on testdb.* from 'test'@'localhost';#收回select 权限；


允许这个用户能够给其他用户授权，后加 WITH GRANT OPTION；
GRANT  ALL  ON   *.*   TO  ’aaa‘@'%'  WITH GRANT OPTION；

设置密码：
SET  PASSWORD  FOR  ‘username’@‘host’ = PASSWORD(‘newpassword’)； 
如果是设置当前用户的密码：
SET  PASSWORD = PASSWORD('newpassword')；


help 命令


忘记用户名及密码

修改启动文件：添加

--skip-grant-tables --skip-networking#跳过授权表
或者是 mysqld_safe --skip-grant-tables&  #跳过授权表
或者是 打开my.ini，在[mysqld]段下添加：skip-grant-tables #跳过授权表

进入mysql 
set password for 'root'@'localhost'=password('new-password')




\--------------------------------------------------
35_02_MySQL系列之十四——MySQL备份和恢复-2019.02.20


MySQL的备份和还原
备份：副本
	RAID1,RAID10:保证硬件损坏而不会导致业务中止；
	DROP TABLE mydb.tb1;
		
	备份类型：
		热备份、温备份、冷备份
			热备份：读写不受影响
			温备份：仅可以执行读操作
			冷备份：离线备份；读写操作均中止
		
		物理备份和逻辑备份
			物理备份：复制数据文件
			逻辑备份：将数据导出至文本文件中；
		
		完全备份、增量备份、差异备份
			完全备份：备份全部数据
			增量数据：仅备份上次完全备份或增量备份以后变化的数据
			差异数据：仅备份上次完全备份以来变化的数据；


​		
​	在线：物理完全备份

还原：
	时常演练、还原操作、谨慎、敬畏
	
	备份什么：
		数据、配置文件、二进制日志、事务日志

热备份：
	MyISAM：不可以热备份；最好进行温备份；锁定数据
	InnoDB:可以热备（注意：热备会占用服务器资源）
			xtrabackup,mysqldump
离线备份最靠谱！ 利用主从架构；

物理备份：速度快
逻辑备份：速度慢、丢失浮点数精度；方便使用文本处理工具对其直接处理、可移植性强；


备份策略：完全+增量；完全+差异（一天\周\月完全+小时\天\周增量\差异  根据数据变化的快慢，容忍还原时间的长短）
（注意还原时间！！！）

MySQL备份工具：
	mysqldump:逻辑备份工具；MyISAM（温）、InnoDB（热）
	mysqlhotcopy:物理备份工具、温备份

文件系统工具：
	cp：冷备
	lv:逻辑卷的快照功能，几乎热备；
		mysql>FLUSH TABLES;
		mysql>LOCK TABLES;
		
		创建快照：释放锁，而后复制数据
		
		InnoDB：确认InnoDB存储引擎缓存区中的数据都已导入数据库，时间可能会很长

专业商业工具：
	ibbackup:商业工具
	xtrabackup:开源工具
	
mysqldump:逻辑备份
	mysqldump(完全备份) + 二进制文件
	完全+增量；


备份单个数据库，或库中特定表	
	mysqldump DB_NAME [tb1][tb2]
	--master-data={0|1|2}
		0:不记录二进制日志文件及位置
		1：以CHNAGE MASTER TO的方式记录位置，可用于恢复后直接启动从服务器；
		2：以CHANGE MASTER TO的方式记录位置，但默认为被注释；
	
	--lock-all-tables:锁定所有表
	
	--flush-logs：执行日志flush;
	
	如果指定库中的表类型均为INnoDB，可使用--single-transaction 启动热备；
	
	备份多个库：
		--all-database:备份所有库
		--databases DB_name,DB_name,... :备份多个指定库
		
		--events
		--routines
		--triggers
	
	备份策略：周完全+日增量
		完全备份：mysqldump
		增量备份：备份二进制文件（flush logs）
		
		查看数据库各表大小：SELECT table_name AS "Tables",round(((data_length + index_length) / 1024 / 1024), 2) as "size MB" FROM information_schema.TABLES WHERE table_schema = 'zabbix' ORDER BY (data_length + index_length) DESC;
		完全备份：mysqldump -uroot -p --master-data=2 --flush-logs --all-databases --lock-all-tables > /data/alldatabases.sql
		
		查看二进制日志位置：less alldatabases.sql
		查看二进制日志：>show binary logs;
		删除这之前的日志：>purge binary logs to 'mysql-bin.000002';
		
		某一天的操作：插入删除...等等
		
		增量备份之前：>FLUSH LOGS;
		增量备份：mysqlbinlog mysql-bin.000002 >/data/firstday-incremental.sql
		
		某两天的操作：。。。。
		
		数据库挂了
		
		killall mysqld
		数据库初始化：scripts/mysql_install_db --
		启动mysql服务
		先还原全量备份：mysql -uroot -p < all-database.sql
		再还原增量备份：mysql -uroot -p < firstday-incremental.sql
		
		再还原最后的操作：mysqlbinlog mysql-bin.000003 >temp.sql
						 或mysqlbinlog mysql-bin.000003 |mysql -uroot -p
		
		mysql -uroot -p <temp.sql
	例：
	mysqldump -uroot -p zabbix > /data/zabbix.sql 

​	mysql>CREATE DATABASE zabbix;

​	#mysql zabbix < /data/zabbix.sql
​	
​	
​	热备之前必须锁表！！
​	mysql>LOCK TABLES;
​	mysql>FLUSH TABLES WITH READ LOCK;
​	mysql>FLUSH LOGS;
​	mysql>FLUSH BINARY LOGS;
​	
​	mysqldump 适合于数据较少的库；
​	作业：
​		编写mysql完全备份及增量备份脚本（也可以编写数据还原脚本）
​		
​	
​	

















\-----------------------------------------------
42_01_MySQL主从复制——概念及架构详解-2019.02.27

mysql:
	大规模。高并发web服务器体系结构：
	
mysql复制，nginx,lnmp，mencached,tomcat(java,servlet,集群)，varnish(squid)

nosql(redis,mongondb)

二进制日志
事物日志
错误日志
一般查询日志
中继日志
慢查询日志

二进制日志：
	数据目录
	mysql-bin.xxxxx
		滚动：达到最大上限，flush logs,服务器重启
		mysql>purge 
	
	二进制日志的格式：
		statement
		row
		mixed
		
	mysql-bin.index:二进制日志文件的索引文件
	
	mysql>show master status;#查看现在用的是哪个二进制日志文件；
	mysql>show binary logs;#查看可用的二进制日志文件列表
	mysql>show binlog event in "file";#查看某二进制日志文件内容；


​	event:
​		timestamp
​		position,offset，OPERATION,server.id
​		事件本身：
​		
即时点还原：
​	mysql:tx1
​	
​	mysql隔离级别：
​		read-uncommitted
​		read-committed
​		repeatable-read
​		serializable



master ---->   slave

bin-log ---->  relay log
、

一主多从
多级复制

复制的作用：
	辅助实现备份
	高可用
	异地容灾
	scale out:分摊压力
	
主从架构中，不使用mysql代理，如何让主复制写，从复制读？

双主：无法减轻写操作；

双主模型：

tutors:name,age,gender,tid

tom 10
jerry 30

A:update tutors set name=jerry where age=10;
B:update tutors set age=30 where name=tom;


mysql代理
	读写分离


memcached

分库：
	垂直（根据热区（公司业务））
	水平（分表）

读写分离：
		mysql-proxy
		amoeba

数据库拆分：		
		cobar:


​	
​	
​	
​	
​	
​	