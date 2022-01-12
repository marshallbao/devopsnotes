1、设置prometheus身份认证，添加变量

```
MINIO_PROMETHEUS_AUTH_TYPE: public
```

2、数据采集路径为

 `metrics_path: /minio/prometheus/metrics`