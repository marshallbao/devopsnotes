1、新建监控账号

```
db.createUser({ 
    user: "mongodb_exporter",
    pwd: "exporterpassword",
    roles: [
        { role: "readAnyDatabase", db: "admin" },
        { role: "clusterMonitor", db: "admin" }
    ]
});
```

2、启动 mongo-cluster-exporter

3、