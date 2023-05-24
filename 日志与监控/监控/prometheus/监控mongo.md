1、新建监控账号

```
use admin
db.createUser({ 
    user: "mongodb_exporter",
    pwd: "exporterPassword",
    roles: [
        { role: "read", db: "local" },
        { role: "clusterMonitor", db: "admin" }
    ]
});
```

2、启动 mongo-cluster-exporter

3、