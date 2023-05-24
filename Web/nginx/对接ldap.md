方式1： 使用现有的 docker 镜像

```
docker run -it -d axistools/nginx-ldap:1.23.4-alpine
```



方式2： 编译安装带 nginx-auth-ldap 第三方模块的 nginx



相关配置 

```
# 声明一个 ldap_server
ldap_server openldap {
    url ldap://139.224.250.204:389/DC=bianjie,DC=ai?cn?sub?(objectClass=PosixAccount);
    binddn "cn=admin,dc=bianjie,dc=ai";
    binddn_passwd "J3EH8BQ8CZMM";
    group_attribute memberUid;
    group_attribute_is_dn on;
    require group "cn=user,ou=chatgpt-dev,ou=service,ou=group,dc=bianjie,dc=ai";
}

# server 模块配置 ldap,也可以在 location 层配置
server {
    listen       80;
    server_name  localhost;
    location / {
        root   /usr/share/nginx/html;
        index  index.html index.htm;
    stub_status on;
    auth_ldap "Forbidden";
    auth_ldap_servers openldap;
    }
}
```

参考

https://github.com/kvspb/nginx-auth-ldap/blob/master/example.conf