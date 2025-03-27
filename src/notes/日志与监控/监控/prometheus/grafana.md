# Grafana



Query Options

```
# Grafana 在绘制图表时所限制的最大数据点数量。这个限制是为了确保图表在渲染时不会变得过于拥挤或影响性能。
Max data points = 1000

# 用于指定查询的最小时间间隔
Min interval = 10s

# 在 Grafana 中，interval 是指在给定的时间范围内，数据应该按多大间隔进行聚合。通常是“时间范围 / 最大数据点数”的结果
Interval = x Time range / max data points

# 允许你在仪表板上设置一个相对时间段
Relative time = 1h

# 允许你在执行查询时将时间范围向前或向后移动
Time shift = 1h

```



常用变量

```
# 用户选择的时间范围，单位 s
$__range

# 用户选择的时间范围 / 数据点数量  ---> 每个图表数据点的间隔时间
$__interval

# 
$__rate_interval
```



参考

https://www.cnblogs.com/Star-Haitian/p/16594559.html