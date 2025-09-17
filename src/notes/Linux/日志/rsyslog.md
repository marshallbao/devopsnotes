# rsyslog

安装

```
yum install  rsyslog
```



配置文件

```
# 核心配置文件，定义 rsyslog 的运行规则
/etc/rsyslog.conf

# 服务启动时的 环境变量和启动参数
/etc/sysconfig/rsyslog
```



rsyslog.d/remote.conf 配置接收远程服务器推送的日志

```
###############################
# Modules
###############################
# 接收远程日志模块
module(load="imudp")
input(type="imudp" port="514" ruleset="RemoteRuleSet")

module(load="imtcp")
input(type="imtcp" port="514" ruleset="RemoteRuleSet")

###############################
# Templates
###############################

# 按主机名和程序名存储远程日志
$template RemoteLogs,"/var/log/remote/%HOSTNAME%/%PROGRAMNAME%.log"

###############################
# Rulesets
###############################

# 远程日志专用规则集
ruleset(name="RemoteRuleSet") {
    # 所有日志写入 RemoteLogs
    *.* ?RemoteLogs

    # 防止日志继续匹配默认规则
    *.* ~
}

```

