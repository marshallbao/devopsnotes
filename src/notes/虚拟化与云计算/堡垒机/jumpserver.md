# JumpServer

### 架构





### 组件说明

- Core 组件是 JumpServer 的核心组件，其他组件依赖此组件启动。
- Koko 是服务于类 Unix 资产平台的组件，通过 SSH、Telnet 协议提供字符型连接。
- Lion 是服务于 Windows 资产平台的组件，用于 Web 端访问 Windows 资产。
- XRDP 是服务于 RDP 协议组件，该组件主要功能是通过 JumpServer Client 方式访问 windows 2000、XP 等系统的资产。
- Razor 是服务于 RDP 协议组件，JumpServer Client 默认使用 Razor 组件访问 Windows 资产。
- Magnus 是服务于数据库的组件，用于通过客户端代理访问数据库资产。
- Kael 是服务于 GPT 资产平台的组件，用于纳管 ChatGPT 资产。
- Chen 是服务于数据库的组件，用于通过 Web GUI 方式访问数据库资产。
- Celery 是处理异步任务的组件，用于执行 JumpServer 相关的自动化任务。
- Video 是专门处理 Razor 组件和 Lion 组件产生录像的格式转换工作，将产生的会话录像转化为 MP4 格式。
- Panda 是基于国产操作系统的应用发布机，用于调度 Virtualapp 应用。



参考

https://docs.jumpserver.org/zh/v3/architecture/#1