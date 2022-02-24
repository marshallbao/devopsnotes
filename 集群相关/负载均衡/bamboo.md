Bamboo是一个Web守护程序，可自动为Apache Mesos和Marathon上部署的Web服务配置HAProxy 。

它的特点是：
• 用于为每个Marathon应用程序配置HAProxy ACL规则的用户界面
• Rest API用于配置代理ACL规则
• 根据您的模板自动配置HAProxy配置文件; 您可以在生产中配置自己的模板以启用SSL和HAProxy统计信息接口，或配置不同的负载平衡策略
• 如果Marathon应用程序配置了Healthchecks，则可以选择处理运行状况检查端点
• 守护进程本身就是无国籍的; 实现水平复制和可扩展性
• 在Golang中开发，在HAProxy实例上的部署没有额外的依赖性
• （可选）与StatsD集成以监视配置重新加载事 