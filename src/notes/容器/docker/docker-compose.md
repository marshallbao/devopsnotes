# Docker-compose

### 安装

直接去 github 仓库 下载对应系统的二进制即可，例如

https://github.com/docker/compose/releases/tag/v2.26.1





### 概念

network



volumes



env_file





### 常用命令

docker-compose 单独启动某个服务

```
# 启动
docker-compose -f docker-compose-wallet.yml up -d wallet-binancesmart

# 停止
docker-compose  -f docker-compose-wallet.yml  stop wallet-binancesmart-testnet

# 启动
start

# 强制重新创建
up --force-recreate

# 删除
rm
```



### 示例

示例 1

```
# docker-compose.yaml
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

示例 2

```
services:
  teable:
    image: registry.cn-shenzhen.aliyuncs.com/teable/teable-ee:latest
    restart: always
    ports:
      - '3000:3000'
    volumes:
      - teable-data:/app/.assets:rw
    env_file:
      - .env
    environment:
      - NEXT_ENV_IMAGES_ALL_REMOTE=true
    networks:
      - teable
    depends_on:
      teable-db:
        condition: service_healthy
    healthcheck:
      test: ['CMD', 'curl', '-f', 'http://localhost:3000/health']
      start_period: 5s
      interval: 5s
      timeout: 3s
      retries: 3

  teable-db:
    image: registry.cn-shenzhen.aliyuncs.com/teable/postgres:15.4
    restart: always
    ports:
      - '5432:5432'
    volumes:
      - teable-db:/var/lib/postgresql/data:rw
    environment:
      - POSTGRES_DB=${POSTGRES_DB}
      - POSTGRES_USER=${POSTGRES_USER}
      - POSTGRES_PASSWORD=${POSTGRES_PASSWORD}
    networks:
      - teable
    healthcheck:
      test: ['CMD-SHELL', "sh -c 'pg_isready -U ${POSTGRES_USER} -d ${POSTGRES_DB}'"]
      interval: 10s
      timeout: 3s
      retries: 3


networks:
  teable:
    name: teable-network

volumes:
  teable-db: {}
  teable-data: {}

```

参考

https://docs.docker.com/compose/install/standalone/