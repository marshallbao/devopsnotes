1、监控账号

```mysql
> CREATE USER 'exporter'@'%' IDENTIFIED BY 'exporterpassword';
> GRANT PROCESS, REPLICATION CLIENT ON *.* TO 'exporter'@'%' WITH MAX_USER_CONNECTIONS 3;
> GRANT SELECT ON performance_schema.* TO 'exporter'@'%' WITH MAX_USER_CONNECTIONS 3;
```

2、部署mysql_exporter