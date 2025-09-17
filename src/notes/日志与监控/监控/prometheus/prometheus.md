# Prometheus



### 安装部署

docker 单机

```
docker run -d  -v /prometheus/data:/prometheus -p /prometheus/config:/etc/prometheus/ -p 9090:9090 prom/prometheus:v3.5.0
```



指标数据类型

Prometheus四种主要的指标类型包括 Counter、Gauge、Histogram和Summary

Counter

只增不减的计数器，用于描述某个指标的累计状态，比如请求量统计，http_requests_total。重启进程后会被重置。

Gauge

可增可减的计量器，用于描述某个指标当前的状态，比如系统内存余量，node_memory_MemFree_bytes。重启进程后会被重置。

Histogram

直方图（可以通俗的用柱状图来理解）指标用于描述指标的分布情况，比如对于请求响应时间，总共10w个请求，小于 10ms 的有 5w 个，小于 50ms 的有 9w 个，小于 100ms 的有 9.9w 个

Summary

和直方图类似，summary 也是用于描述指标分布情况，不过表现形式不同（它提供一个quantiles 的功能，可以按%比划分跟踪的结果）。比如还是对于请求响应时间，summary描述则是，总共10w个请求，50%小于10ms，90%小于50ms，99%小于100ms。
Summary 相比 Histogram 的使用场景会比较多一些，因为对服务端资源需求更少，但是在查询时 histogram 的资源消耗会比 summary 相对于更多。其实也就是 summary 把资源消耗转移到了服务端，指标的分布数据是计算好再导出的。