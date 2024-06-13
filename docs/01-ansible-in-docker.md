进入 `ansible-docker` 目录，按以下步骤创建容器。

# 制作并启动 ansible 容器

```
cd ansible-docker
docker-compose up -d --build
```

# 进入容器环境


容器内默认使用 omm 用户，id 1001。因此克隆下来的目录需首先改变所属权，`/path/to/ansible-for-opengauss` 改为实际的目录。这个改动同样适用于非 root 用户但 id 不是 1001 的情况。

```
chown -R 1001:1001 /path/to/ansible-for-opengauss
```

进入容器

```
docker exec -it ansible-for-opengauss byobu
```

如果你使用的是 root 账号，请指定以 root 用户进入容器内。

```
docker exec -it -uroot ansible-for-opengauss byobu
```

# 声明

我个人比较喜爱使用 [fish](https://fishshell.com/) 作为默认的 shell，以及使用 [byobu](https://www.byobu.org/documentation) 作为单窗口多终端的工作环境。如果您不喜欢，可以自行修改 Dockerfile 的内容。

接下来你可以阅读[详细配置](02-pre-set.md)，仅需按分组编排服务器节点的角色，即可开始全自动化部署。
