本文内容适合对熟悉 Ansible 的同学看。如果你对 Ansible 不了解，请看 [创建 Ansible 容器](01-ansible-in-docker.md)，使用 docker 快速搭建一个可以运行本项目的 ansible 环境，降低对操作系统的依赖。


# hosts.ini 示例

master 组仅可以配置 1 台机器。follower 可以多台。cascade 可选可为空。

```
[opengauss_master]
192.168.56.11

[opengauss_follower]
192.168.56.12

[opengauss_cascade]
192.168.56.13

[openGauss:children]
opengauss_master
opengauss_follower
opengauss_cascade
```

# playbook.yml 示例

```
- name: Deploy openGauss
  hosts: openGauss
  become: true
  become_flags: "-i"
  roles:
    - openGauss
```

# 效果展示

本地物理机，启动 6 台虚拟机，用时 9 分 30 秒完成 1 主 4 从 1 级联的架构部署。

![用时](imgs/23-09-20_1243_661.png)

![集群状态](imgs/23-09-20_923_628.png)