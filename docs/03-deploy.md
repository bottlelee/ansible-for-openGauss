# 开始部署

建议使用前文提到的 Ansible 容器执行部署，避免系统差异、ansible 版本差异等一系列问题造成的运行失败。本项目全部基于 Ansible in Docker 来测试开发。

1. 进入 ansible 环境

    ```
    docker exec -it ansible byobu
    ```

    关于 byobu 的使用，大家可自行搜索一些教程。

1. 执行部署

    ```
    pansible 01-deploy.yml
    ```

    这里的 `pansible` 是我预置的命令别名，对应的是 `ansible-playbook`。

# 顺利部署后，你可看到一下输出内容

## 单节点

![单节点](imgs/1695614019309.png)

对应的 hosts.ini 分组编排内容

```
[openGauss_master]
192.168.56.11

[openGauss_follower]

[openGauss_cascade]

[openGauss:children]
openGauss_master
openGauss_follower
openGauss_cascade
```

## 1 主 1 从

![1主1从](imgs/1695614019287.png)
对应的 hosts.ini 分组编排内容

```
[openGauss_master]
192.168.56.12

[openGauss_follower]
192.168.56.13

[openGauss_cascade]

[openGauss:children]
openGauss_master
openGauss_follower
openGauss_cascade
```

## 1 主 1 从 1 级联

![1主1从1级联](imgs/1695614019263.png)
对应的 hosts.ini 分组编排内容

```
[openGauss_master]
192.168.56.14

[openGauss_follower]
192.168.56.15

[openGauss_cascade]
192.168.56.16

[openGauss:children]
openGauss_master
openGauss_follower
openGauss_cascade
```

## 1 主 2 从

![1主2从](imgs/1695614019240.png)
对应的 hosts.ini 分组编排内容

```
[openGauss_master]
192.168.56.17

[openGauss_follower]
192.168.56.18
192.168.56.19

[openGauss_cascade]

[openGauss:children]
openGauss_master
openGauss_follower
openGauss_cascade
```