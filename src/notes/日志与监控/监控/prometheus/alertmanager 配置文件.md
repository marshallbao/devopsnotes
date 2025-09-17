# AlertManager 配置

Alertmanager 主要负责对 Prometheus 产生的告警进行统一处理，因此在 Alertmanager 配置中一般会包含以下几个主要部分：

- 全局配置（global）：用于定义一些全局的公共参数，如全局的SMTP配置，Slack配置等内容；
- 模板（templates）：用于定义告警通知时的模板，如HTML模板，邮件模板等；
- 告警路由（route）：根据标签匹配，确定当前告警应该如何处理；
- 接收人（receivers）：接收人是一个抽象的概念，它可以是一个邮箱也可以是微信，Slack或者Webhook等，接收人一般配合告警路由使用；
- 抑制规则（inhibit_rules）：合理设置抑制规则可以减少垃圾告警的产生

其完整配置格式如下：

```yaml
global:
  [ resolve_timeout: <duration> | default = 5m ]
  [ smtp_from: <tmpl_string> ] 
  [ smtp_smarthost: <string> ] 
  [ smtp_hello: <string> | default = "localhost" ]
  [ smtp_auth_username: <string> ]
  [ smtp_auth_password: <secret> ]
  [ smtp_auth_identity: <string> ]
  [ smtp_auth_secret: <secret> ]
  [ smtp_require_tls: <bool> | default = true ]
  [ wechat_api_url: <string> | default = "https://qyapi.weixin.qq.com/cgi-bin/" ]
  [ wechat_api_secret: <secret> ]
  [ wechat_api_corp_id: <string> ]
  [ http_config: <http_config> ]
templates:
  [ - <filepath> ... ]
route: <route>
   group_interval: 5m
   group_wait: 10s
   repeat_interval: 3h
   routes:
   - receiver: 'discord-prod'
     match_re:
       cluster: app

receivers:
  - name: 'default-receiver'
    webhook_configs:
    - url: 'http://monitor-alertmanager-webhook-dingtalk:8060/dingtalk/cloud/send'
inhibit_rules:
  [ - <inhibit_rule> ... ]
```

其中要注意的是，resolve_timeout 参数为 alertmanager 持续多长时间未接收到告警后标记告警状态为resolved