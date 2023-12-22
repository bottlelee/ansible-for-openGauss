# 执行 playbook 之前的准备工作。

## 修改 `/workdir/inventories/opengauss/hosts.ini` 文件

这个文件是对你要部署的机器，进行一个分组编排，以及 ssh 信息填写。以 1 主 1 从 1 级联的架构为例，它的内容如下：

```
; 主服务器组，仅设置 1 个目标机。
[opengauss_primary]
192.168.56.11

; 从服务器组，可设置若干个或留空。
[opengauss_standby]
192.168.56.12

; 级联服务器组，可设置若干个或留空。
[opengauss_cascade]
192.168.56.13

; 以上 3 个分组的合并组，勿动。
[opengauss:children]
opengauss_primary
opengauss_standby
opengauss_cascade

; 机器的 SSH 信息，请根据你的实际情况修改。
[opengauss:vars]
; ssh 用户名，如果不是 root 用户，请确保它有 sudo 权限。
ansible_ssh_user=vagrant
; ssh 密码
ansible_ssh_pass=vagrant
; ssh 端口
ansible_ssh_port=22
```

## 根据部署需求，修改变量文件。

首先拷贝默认变量配置文件

```
cp /workdir/roles/opengauss/defaults/main.yml /workdir/inventories/opengauss/group_vars/all.yml
```

然后使用你习惯的编辑器修改 `/workdir/inventories/opengauss/group_vars/all.yml` 里的内容。

内容可以按官方文档的要求、建议，或你的实际需求，进行增删改，保留数据结构即可。

譬如目标机器是有额外数据盘的，挂载在 `/opengauss_data` 路径下，那么你可以修改

```
# 安装目录
opengauss_home: /opt/openGauss
```

为

```
# 安装目录
opengauss_home: /opengauss_data
```

我们的脚本会通过 `/workdir/roles/pre-tasks/tasks/vars_combine.yml` 的处理后，替换默认变量并放置在 `combined_vars` 数组内。

```
combined_vars:
  opengauss_home: /opengauss_data
```

整个部署任务，都会大量使用 combined_vars 里的变量。

# 使用自定义的 cluster_config.xml

如果你需要手动定制集群，这里也是支持的。

前提：

  1. 确保 `/workdir/inventories/opengauss/hosts.ini` 的角色编排，和你的 `cluster_config.xml` 内容一致。

  2. 已有节点的编号顺序，在 `cluster_config.xml` 需要严格保持一致。

然后把写好的 `cluster_config.xml` 改名为 `cluster_config.xml.j2`，存放到 `/workdir/inventories/opengauss/templates/cluster_config.xml.j2`，部署时会优先使用你的自定义配置。

接下来就可以 [开始部署](03-deploy.md)。