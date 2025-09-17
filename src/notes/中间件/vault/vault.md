# Vault





常用操作

```
查看主从
knjqa exec -it vault-1 -n vault --  vault operator raft list-peers  

切换 leader
knjqa exec -it vault-1 -n vault --  vault operator step-down 

解封 vault（5个unseal keys的话，需要提供三个，依次执行三次）
knjqa exec -nvault vault-3 -- vault operator unseal Zu6EdLIF***
```

