FROM alpine
LABEL Creator="haibin.l@linkingcloud.cn"
ARG TIMEZONE="Asia/Shanghai"

ADD ssh_config /root/.ssh/config

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.cloud.tencent.com/g' /etc/apk/repositories \
  && apk --no-cache add bzip2 nano ansible fish byobu \
    sshpass tzdata rsync wget curl net-tools tar unzip \
    openssh-client py3-netaddr musl-locales py3-jmespath

RUN byobu-select-backend tmux \
  && byobu-ctrl-a screen \
  && byobu-enable \
  && ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime \
  && sed -i 's/\/bin\/ash/\/usr\/bin\/fish/g' /etc/passwd \
  && fish -c "alias pansible='ansible-playbook' && funcsave pansible"