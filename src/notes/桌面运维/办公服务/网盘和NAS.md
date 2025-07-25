# 网盘和 NAS



### 网盘

minio





### NAS

seafile



网盘&NAS

seafile

https://cloud.seafile.com/wiki/publish/seafile-manual/hk5G/

NextCloud

```
sudo docker run \
--init \
--sig-proxy=false \
--name nextcloud-aio-mastercontainer \
--restart always \
--publish 80:80 \
--publish 8080:8080 \
--publish 8443:8443 \
--volume nextcloud_aio_mastercontainer:/mnt/docker-aio-config \
--volume /var/run/docker.sock:/var/run/docker.sock:ro \
ghcr.io/nextcloud-releases/all-in-one:latest
```

https://github.com/nextcloud/all-in-one?tab=readme-ov-file#how-to-use-this

https://nextcloud.com/install/#aio

参考

https://www.collick.cn/index.php/archives/522/

https://gitcode.csdn.net/65aa2e09b8e5f01e1e44c47d.html

https://www.cnblogs.com/aeolian/p/18778656