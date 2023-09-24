# 测试环境搭建

1. （可选）Vagrantfile。默认启动 4 台 4U16G 的 Virtualbox 虚拟机，如果你的机器配置无法满足，请适当修改相关参数 `vb.memory` 和 `vb.cpus`。降低这 2 个参数可能会导致某些部署无法测试成功。
1. Dockerfile。基于 Alpine Linux 容器镜像，制作一个运行 Ansible 的 Docker 镜像，解决某些离线环境里安装软件的问题。
1. docker-compose.yml。Ansible 容器使用用例，请根据实际需要进行修改。

## 步骤

```
# 启动虚拟机。（需要已安装 vagrant、virtualbox）
vagrant up

# 制作 ansible 容器镜像
docker-compose build

# 启动 ansible 容器
docker-compose up -d

# 进入容器环境
docker exec -it ansible byobu
```
