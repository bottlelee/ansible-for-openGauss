FROM alpine
LABEL Creator="haibin.lee@foxmail.com"
ARG TIMEZONE="Asia/Shanghai"

RUN addgroup dbgrp \
  && adduser -D -G dbgrp omm \
  && sed -i 's/dl-cdn.alpinelinux.org/mirrors.cloud.tencent.com/g' /etc/apk/repositories \
  && apk upgrade -U --no-cache \
  && apk --no-cache add bzip2 nano py3-pip fish byobu \
    sshpass tzdata rsync wget curl net-tools tar unzip \
    openssh-client py3-netaddr musl-locales py3-jmespath \
    busybox-extras vim \
  && ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime \
  && sed -i 's/\/bin\/ash/\/usr\/bin\/fish/g' /etc/passwd \
  && echo ". /home/omm/.pyansible/bin/activate" | tee -a /root/.profile \
  && mkdir -p /root/.ssh \
  && mkdir -p /home/omm/.ssh

COPY ssh_config /root/.ssh/config
COPY ssh_config /home/omm/.ssh/config

RUN chown -R omm:dbgrp /home/omm

USER omm

RUN python3 -m venv /home/omm/.pyansible \
  && . /home/omm/.pyansible/bin/activate \
  && pip install -i https://mirrors.tencent.com/pypi/simple -U pip \
  && pip install -i https://mirrors.tencent.com/pypi/simple -U ansible==9 netaddr

RUN byobu-select-backend tmux \
  && byobu-ctrl-a screen \
  && byobu-enable \
  && fish -c "alias pansible='ansible-playbook' && funcsave pansible" \
  && echo ". /home/omm/.pyansible/bin/activate" | tee -a /home/omm/.profile

