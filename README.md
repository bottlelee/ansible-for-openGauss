# Ansible role for openGauss

本项目基于 openGauss 的官方安装脚本，结合 Ansible 自动化编排流程，实现自动部署 openGauss。

使用者只需给目标机器编排好集群角色，即可通过一行命令，自适应部署单点、一主一备、一主多备以及级联节点等架构模式。

本项目适用于以下场景或用户：

1. 同一网络环境下的快速部署以及扩容。
1. 需要多次重新部署数据库集群的测试工程师。

# 已适配的系统

* x86_64
  * CentOS 7.6
  * openEuler 20.03 LTS SP3

# 已适配的 openGauss 版本

* 5.1.0
* 5.0.0

# 不足之处

1. 暂不支持 DCF 模式的集群部署。
1. 暂不支持离线部署。
1. 暂不支持多地容灾部署。
1. 暂不提供部署后的数据库或数据库用户的创建流程。

# 优势特点

1. 自带 Dockerfile，可通过 docker-compose 在本地启动一个 Ansible 容器，免除不同系统安装 Ansible 所带来的兼容性问题。
1. 部署完成后自动生成部署报告，markdown 格式。
1. 以 1 主 4 备 1 级联的架构为例，十分钟内部署完成（不含 openGauss 压缩包及 Linux 系统安装包的下载时间）。
1. 支持从 1 主单节点，逐步扩展为多节点集群。
1. 自动匹配 CPU 架构以及操作系统。
1. 支持自定义 cluster_config.xml.j2 模板，优先使用 `{{ inventory_dir }}/templates/openGauss/cluster_config.xml.j2`。
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

    自定义变量文件 `{{ inventory_dir }}/group_vars/openGauss.yml`

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

# 使用指南

* [快速开始](docs/00-how-to.md)，适合熟悉 Ansible 的同学。
* [创建 Ansible 容器](docs/01-ansible-in-docker.md)，使用 docker 快速搭建一个可以运行本项目的 ansible 环境，降低对操作系统的依赖。
* [详细配置](docs/02-pre-set.md)
* [开始部署](docs/03-deploy.md)
* [节点扩容](docs/04-expansion.md)

# 更新日志

* 2023-11-10：优化流程，解决扩容难点，可直接从单节点扩容到多节点。
* 2023-10-26: 大量修复和优化，可完美实现从单点部署，到逐步扩容为 1 主 4 备 4 级联的架构。
  ```
  已测试的扩容场景如下

  1 主
    -> 1 主 1 备
      -> 1 主 1 备 1 级联
        -> 1 主 2 备 2 级联
          -> 1 主 4 备 4 级联
  ```
* 2023-10-18: 支持 openEuler 20.03 LTS SP3。
* 2023-10-13: 支持集群扩容。

# 待开发功能

1. 提供 DCF 模式的部署。
1. 基于 gs_guc 批量配置自动修改功能。

# 开发指南

（待补充）

# 问题反馈

请提交 [issue](https://gitee.com/opengauss/ansible-for-opengauss/issues)，或电邮与我联系 haibin.l@linkingcloud.cn