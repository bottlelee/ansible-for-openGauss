# 执行 playbook 之前的准备工作。

## 修改 `ansible-docker\inventories\opengauss\hosts.ini` 文件

这个文件是对你要部署的机器，进行一个分组编排，以及 ssh 信息填写。以 1 主 1 从 1 级联的架构为例，它的内容如下：

```
; 主服务器组，仅设置 1 个目标机。
[openGauss_master]
192.168.56.11

; 从服务器组，可设置若干个或留空。
[openGauss_follower]
192.168.56.12

; 级联服务器组，可设置若干个或留空。
[openGauss_cascade]
192.168.56.13

; 以上 3 个分组的合并组，勿动。
[openGauss:children]
openGauss_master
openGauss_follower
openGauss_cascade

; 机器的 SSH 信息，请根据你的实际情况修改。
[openGauss:vars]
; ssh 用户名，如果不是 root 用户，请确保它有 sudo 权限。
ansible_ssh_user=vagrant
; ssh 密码
ansible_ssh_pass=vagrant
; ssh 端口
ansible_ssh_port=22
```

## 修改默认运行值。

本项目的默认配置参数，存放在 `roles\openGauss\defaults\main.yml`，你可以参考这个文件的内容，根据实际需要做一些定制。*** 但不建议直接修改它，以考虑对不同的服务器仓库进行维护 ***

建议的自定义方法，是将 `roles\openGauss\defaults\main.yml` 拷贝到 `ansible-docker\inventories\opengauss\group_vars\openGauss.yml`，再进行编辑。

部分变量是可以替换或扩展的。例如

```
# Sysctl 的配置，可自行扩展。
openGauss_sysctl:
  net.ipv4.tcp_retries1: 5
  net.ipv4.tcp_syn_retries: 5
```

你可以改成

```
# Sysctl 的配置，可自行扩展。
openGauss_sysctl:
  net.ipv4.tcp_retries1: 5
  net.ipv4.tcp_syn_retries: 3
  net.ipv4.tcp_synack_retries： 5
```

通过 `roles\pre-tasks\tasks\vars_combine.yml` 的处理后，我们可以得到一组合并后的变量

```
combined_vars:
  openGauss_sysctl:
    net.ipv4.tcp_retries1: 5
    net.ipv4.tcp_syn_retries: 3
    net.ipv4.tcp_synack_retries： 5
```

整个部署任务，都会大量使用 combined_vars 里的变量。

# 使用自定义的 cluster_config.xml

如果你需要手动定制集群，这里也是支持的，只需要把写好的 `cluster_config.xml` 改名为 `cluster_config.xml.j2`，存放到 `ansible-docker/inventories/opengauss/templates/cluster_config.xml.j2`，部署时会优先使用你的自定义配置。

接下来就可以[开始部署](03-deploy.md)