配置文件

```yaml
global:
  scrape_interval: 15s
  evaluation_interval: 15s
  scrape_timeout: 10s

alerting:
  alertmanagers:
  - static_configs:
    - targets:
      - alertmanager.bianjie.ai
    scheme: http
    timeout: 10s
    api_version: v1

rule_files:
  # - "first_rules.yml"
  # - "second_rules.yml"

scrape_configs:
  - job_name: "prometheus"
    # metrics_path defaults to '/metrics'
    # scheme defaults to 'http'.
    static_configs:
      - targets: ["localhost:9090"]
  - job_name: wenchuang-hosts
    static_configs:
    - targets: [172.16.1.19:9100,172.16.1.20:9100,172.16.1.21:9100,172.16.1.24:9100]
  - job_name: wenchuangchain
    static_configs:
    - targets: [172.16.1.19:26660,172.16.1.20:26660,172.16.1.21:26660,172.16.1.24:26660]
    relabel_configs:
    - source_labels: [__address__]
      target_label: address
    - source_labels: [__address__]
      target_label: instance
      regex: 172.16.1.19:26660
      replacement: wenchuang-validator-1

```

