packer {
  required_plugins {
    virtualbox = {
      version = "~> 1"
      source  = "github.com/hashicorp/virtualbox"
    }
  }
}

source "virtualbox-iso" "openeuler" {
  // guest_os_type = "CentOS_64"
  iso_url = "https://mirror.sjtu.edu.cn/openeuler/openEuler-22.03-LTS-SP2/ISO/x86_64/openEuler-22.03-LTS-SP2-netinst-x86_64-dvd.iso"
  iso_checksum = "sha256:e7186579da6d16430bb8577e2989761e726af8166a08f7e02cde55a614b42d66"
  ssh_username = "vagrant"
  ssh_password = "vagrant"
  shutdown_command = "echo 'vagrant' | sudo -S shutdown -P now"
  boot_command = [
       "<tab><wait>",
    ]
}

build {
  sources = ["sources.virtualbox-iso.openeuler"]
}

