安装

直接去 github 仓库 下载对应系统的二进制即可，例如

https://github.com/docker/compose/releases/tag/v2.26.1



docker-compose 单独启动某个服务

```
docker-compose -f docker-compose-wallet.yml up -d wallet-binancesmart

docker-compose  -f docker-compose-wallet.yml  stop wallet-binancesmart-testnet
```



docker-compose.yaml

```
version: '3'

services:
  cschain-tools:
    image: 10.133.38.190/cschain-otcibr/tools-switch-chain:8749454648c9f6347a37741fb86c0a872dd676eb
    container_name: cschain-tools
    volumes:
      - ./config.toml:/cschain-tools/config.toml:ro
    command: /cschain-tools/config.toml sso_login
    entrypoint: cschain-tools

```

