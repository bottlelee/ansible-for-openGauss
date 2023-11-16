# 集群扩容

***！！！注意！！！***

***实验功能，切勿在生产环境中使用。***

***扩容有风险，操作前请仔细阅读 https://docs.opengauss.org/zh/docs/5.0.0/docs/ToolandCommandReference/gs_expansion.html***

## 修改 `/workdir/inventories/opengauss/hosts.ini` 文件

备机数量不可超过 8 台。

### 请注意：

### 如果是对 1 主 1 备进行扩容，会增加一些部署 Cluster Manager 的流程，耗时较长。请确保扩容前没有数据库读写操作。

### 扩容级联（Cascade）节点的前提是需要有备机（Standby）节点，即  `opengauss_standby` 组必须有分配机器。

假设原编排为 1 主 1 备。

```
; 主服务器组，仅设置 1 个目标机。
[opengauss_primary]
192.168.56.11

; 从服务器组，可设置若干个或留空。
[opengauss_standby]
192.168.56.12
```

增加 2 台备机，2 台级联机，则在对应的组里增加目标服务器。

```
; 主服务器组，仅设置 1 个目标机。
[opengauss_primary]
192.168.56.11

; 从服务器组，可设置若干个或留空。
[opengauss_standby]
192.168.56.12
192.168.56.14
192.168.56.16

; 级联服务器组，可设置若干个或留空。
[opengauss_cascade]
192.168.56.13
192.168.56.15

```

## 扩容

再次执行 `pansible 01-deploy.yml`。

同时，你可以登入到主节点，切换到 root 去查看部署过程中的日志，了解进度。

```
tail -n100 -f /var/log/omm/**/*.log
```

![扩容结果](imgs/23-10-13_1155_909.png)