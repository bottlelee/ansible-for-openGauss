FROM alpine
LABEL Creator="haibin.l@linkingcloud.cn"
ARG TIMEZONE="Asia/Shanghai"

RUN addgroup dbgrp \
  && adduser -D -G dbgrp omm \
  && sed -i 's/dl-cdn.alpinelinux.org/mirrors.cloud.tencent.com/g' /etc/apk/repositories \
  && apk upgrade -U --no-cache \
  && apk --no-cache add bzip2 nano ansible fish byobu \
    sshpass tzdata rsync wget curl net-tools tar unzip \
    openssh-client py3-netaddr musl-locales py3-jmespath \
    inetutils-telnet \
  && ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime \
  && sed -i 's/\/bin\/ash/\/usr\/bin\/fish/g' /etc/passwd

ADD ssh_config /home/omm/.ssh/config

RUN chown -R omm:dbgrp /home/omm \
  && deluser root || echo "User 'root' has been deleted."

USER omm

RUN byobu-select-backend tmux \
  && byobu-ctrl-a screen \
  && byobu-enable \
  && fish -c "alias pansible='ansible-playbook' && funcsave pansible"