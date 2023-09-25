进入 `ansible-docker` 目录，按以下步骤创建容器。

# 制作 ansible 容器镜像

`docker-compose build`

# 启动 ansible 容器

`docker-compose up -d`

# 进入容器环境

`docker exec -it ansible byobu`

# 声明

我个人比较喜爱使用 fish 作为默认的 shell，以及使用 byobu 作为单窗口多终端的工作环境。如果您不喜欢，可以自行修改 Dockerfile 的内容。