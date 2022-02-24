```
alerting:
  alertmanagers:
  - static_configs:
    - targets:
      - alertmanager.bianjie.ai
    scheme: http
    timeout: 10s
    api_version: v1
```