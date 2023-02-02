​         redis6 有了acl管理
redis集群版只使用db0

集群与单体Redis的区别如下：
1、key批量操作支持有限：例如mget、mset必须在一个slot；
2、Key事务和Lua支持有限：操作的key必须在一个节点；
3、key是数据分区的最小粒度：不支持bigkey分区；
4、不支持多个数据库：集群模式下只有一个db0；
5、复制只支持一层：不支持树形复制结构。