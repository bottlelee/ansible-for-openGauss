# Ansible role for openGauss

自动部署 openGauss，根据分组定义，自适应部署单点、一主一从、一主多从以及级联节点等架构模式。

# 已适配的系统

* x86_64
  * CentOS 7.6

# 已适配的 openGauss 版本

* 5.0.0

# 优势特点

1. 1 主 4 从 1 级联的架构，十分钟内部署完成（不含安装包的下载时间）。
1. 自动匹配 CPU 架构以及操作系统。
1. 支持自定义 cluster_config.xml.j2 模板，优先使用 `{{ inventory_dir }}/templates/openGauss/cluster_config.xml.j2`。
1. 默认自动生成数据库管理员密码，也可自定义变量进行替换。全程自动化，无交互步骤。
1. 部署完成后，从 `/root/.ssh/authorized_keys` 里移除相关公钥，而非删除 `/root/.ssh` 目录。
1. 本地生成的公密钥、账号密码，均存放在 `{{ inventory_dir }}/credentials` 目录内。
1. 支持自定义变量，自动与 `defaults/main.yml` 变量合并使用。例如

    默认变量

    ```
    openGauss_env:
      user_name: omm
      user_group: dbgrp
    ```

    自定义变量文件 `{{ inventory_dir }}/group_vars/openGauss.yml`

    ```
    openGauss_env:
      user_name: ommo
    ```

    合并后的可用变量

    ```
    combined_vars:
      openGauss_env:
        user_name: ommo
        user_group: dbgrp
    ```

# 使用指南

* [快速开始](docs/00-how-to.md)，适合熟悉 Ansible 的同学。
* [创建 Ansible 容器](docs/01-ansible-in-docker.md)，使用 docker 快速搭建一个可以运行本项目的 ansible 环境，降低对操作系统的依赖。
* [详细配置](docs/02-pre-set.md)
* [开始部署](docs/03-deploy.md)
* [节点扩容](docs/04-expansion.md)

# 更新日志

* 2023-10-13: 支持集群扩容。

# 开发指南

（待补充）

# 问题反馈

请提交 [issue](https://gitee.com/opengauss/ansible-for-opengauss/issues)，或电邮与我联系 haibin.l@linkingcloud.cn