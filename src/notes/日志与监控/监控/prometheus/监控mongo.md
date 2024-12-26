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

2、启动 mongo-exporter

```
version: '2'

services:
  mongodb-exporter:
    command: ["--mongodb.uri=mongodb://mongodb_exporter:exporterPassword@172.16.1.25:27017/?authSource=admin&replicaSet=rs0", "--web.listen-address=:9216", "--collector.replicasetstatus", "--collector.currentopmetrics"]
    image: percona/mongodb_exporter:0.40.0
    ports:
      - '9216:9216'

```

3、



参考

https://github.com/percona/mongodb_exporter/