# Yearning

## 安装

docker-compose.yaml

```yaml
docker-compose
version: '3'

services:
    yearning:
        image:  yeelabs/yearning:v3.1.9
        environment:
           MYSQL_USER: yearning
           MYSQL_PASSWORD: yearningPassword
           MYSQL_ADDR: mysql
           MYSQL_DB: yearning
           Y_LANG: zh_CN
           SECRET_KEY: dbcjqheupqjsuwsm
           IS_DOCKER: is_docker
        ports:
           - 8000:8000
        # 首次安装需要执行，第二次可以注释掉
        command: /bin/bash -c "./Yearning install && ./Yearning run"
        depends_on:
           - mysql
        restart: always

    mysql:
        image: mysql:5.7
        environment:
           MYSQL_ROOT_PASSWORD: rootPassword
           MYSQL_DATABASE: yearning
           MYSQL_USER: yearning
           MYSQL_PASSWORD: yearningPassword
        command:
           - --character-set-server=utf8mb4
           - --collation-server=utf8mb4_general_ci
        volumes:
           - ./data/mysql:/var/lib/mysql
```

默认密码：admin/Yearning_admin