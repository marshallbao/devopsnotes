限流

```
  annotations:
    nginx.ingress.kubernetes.io/configuration-snippet: |
      limit_req_status 429;
    nginx.ingress.kubernetes.io/limit-burst-multiplier: "5"
    nginx.ingress.kubernetes.io/limit-rps: "20"
    nginx.ingress.kubernetes.io/limit-whitelist: ip
```

Location

```
  annotations:    
    nginx.ingress.kubernetes.io/server-snippet: |
      location = / {
        return 301 https://docs.avata.bianjie.ai;
      }
#
  annotations:
    nginx.ingress.kubernetes.io/server-snippet: |
      location = / {
        proxy_set_header X-Apifox-Project-ID 2471586;
        proxy_pass http://2471586.n3.apifox.cn;
      }
      location /api {
        proxy_set_header X-Apifox-Project-ID 2471586;
        proxy_pass http://2471586.n3.apifox.cn;
      }

```

重写

```
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: https://wenchang.bianjie.ai
```

