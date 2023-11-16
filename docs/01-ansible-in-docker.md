进入 `ansible-docker` 目录，按以下步骤创建容器。

# 制作并启动 ansible 容器

`docker-compose up -d --build`

# 进入容器环境

`docker exec -it ansible-for-opengauss byobu`

# 声明

我个人比较喜爱使用 [fish](https://fishshell.com/) 作为默认的 shell，以及使用 [byobu](https://www.byobu.org/documentation) 作为单窗口多终端的工作环境。如果您不喜欢，可以自行修改 Dockerfile 的内容。

接下来你可以阅读 [详细配置](02-pre-set.md)，也可以 [开始部署](03-deploy.md)