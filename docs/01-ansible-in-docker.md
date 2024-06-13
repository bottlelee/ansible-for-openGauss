进入 `ansible-docker` 目录，按以下步骤创建容器。

# 制作并启动 ansible 容器

```
cd ansible-docker
docker-compose up -d --build
```

# 进入容器环境


Default user is 'omm' in the docker container

```
docker exec -it ansible-for-opengauss byobu
```

If you using 'root' account and you pull the source under any directory that not allowed for other users, use command instead

```
docker exec -it -uroot ansible-for-opengauss byobu
```

# 声明

我个人比较喜爱使用 [fish](https://fishshell.com/) 作为默认的 shell，以及使用 [byobu](https://www.byobu.org/documentation) 作为单窗口多终端的工作环境。如果您不喜欢，可以自行修改 Dockerfile 的内容。

接下来你可以阅读[详细配置](02-pre-set.md)，仅需按分组编排服务器节点的角色，即可开始全自动化部署。
