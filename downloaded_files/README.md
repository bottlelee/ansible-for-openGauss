问：部署环境内内网，需要提前下载安装包，请问下载后需要放在那个位置？

答：你需要手动建立一个 downloaded_files 目录，然后把对应的安装包以 openGauss_<版本号>_<系统发行版>_<系统版本号>_<CPU 架构>.tar.gz 的格式重命名后放入该目录，例子如下：

  haibinl@LACRIMOSA-WORKSTATION ~/W/ansible-for-opengauss (develop) [2]> tree downloaded_files/
  downloaded_files/
  ├── openGauss_5.0.0_CentOS_7.9_x86_64.tar.gz
  └── openGauss_5.0.0_openEuler_20.03_x86_64.tar.gz