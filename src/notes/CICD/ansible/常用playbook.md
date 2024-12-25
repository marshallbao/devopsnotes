# 常用 playbook



执行

```
ansible-playbook your_playbook.yml
```



批量修改密码

```
---
  - hosts: cschain
    gather_facts: false
    tasks:
    - name: change user passwd
      user: name={{ item.name }} password={{ item.chpass | password_hash('sha512') }}  update_password=always
      with_items:
           - { name: 'root', chpass: 'kevin@123' }
           - { name: 'app', chpass: 'bjop123' }
```



参考

https://www.cnblogs.com/kevingrace/p/10601309.html