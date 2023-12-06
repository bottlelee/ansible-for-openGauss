# Ansible role for openGauss

自动部署 openGauss，根据分组定义，自适应部署单点、一主一从、一主多从以及级联节点等架构模式。

目前仅支持初次部署以及扩容，暂不支持对集群角色做变更。

# 优势特点

1. 1 主 4 从 1 级联的架构，十分钟内部署完成（不含安装包的下载时间）。
1. 自动匹配 CPU 架构以及操作系统。
1. 支持自定义 cluster_config.xml.j2 模板，优先使用 `{{ inventory_dir }}/templates/opengauss/cluster_config.xml.j2`。
1. 默认自动生成数据库管理员密码，也可自定义变量进行替换。全程自动化，无交互步骤。
1. 部署完成后，从 `/root/.ssh/authorized_keys` 里移除相关公钥，而非删除 `/root/.ssh` 目录。
1. 本地生成的公密钥、账号密码，均存放在 `{{ inventory_dir }}/credentials` 目录内。
1. 支持自定义变量，自动与 `defaults/main.yml` 变量合并使用。例如

    默认变量

    ```
    opengauss_env:
      user_name: omm
      user_group: dbgrp
    ```

    自定义变量文件 `{{ inventory_dir }}/group_vars/opengauss.yml`

    ```
    opengauss_env:
      user_name: ommo
    ```

    合并后的可用变量

    ```
    combined_vars:
      opengauss_env:
        user_name: ommo
        user_group: dbgrp
    ```

# 已匹配系统

* x86_64
  * CentOS 7.6

# hosts.ini 示例

master 组仅可以配置 1 台机器。follower 可以多台。cascade 可选可为空。

```
[opengauss_primary]
192.168.56.11

[opengauss_standby]
192.168.56.12

[opengauss_cascade]
192.168.56.13

[opengauss:children]
opengauss_primary
opengauss_standby
opengauss_cascade
```

# playbook.yml 示例

```
- name: Deploy openGauss database
  hosts: opengauss
  become: true
  roles:
    - openGauss
```

# 效果展示

本地物理机，启动 6 台虚拟机，用时 9 分 30 秒完成 1 主 4 从 1 级联的架构部署。

![用时](files/23-09-20_1243_661.png)

![集群状态](files/23-09-20_923_628.png)
