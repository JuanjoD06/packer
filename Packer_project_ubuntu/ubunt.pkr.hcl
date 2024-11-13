packer {
  required_plugins {
    vagrant = {
      version = "~> 1"
      source  = "github.com/hashicorp/vagrant"
    }
  }
}

# Variables
variable "ubuntu_iso_url" {
  type    = string
  default = "file:///C:/isos/ubuntu-22.04.5-live-server-amd64.iso"
}

variable "ubuntu_iso_checksum" {
  type    = string
  default = "9bc6028870aef3f74f4e16b900008179e78b130e6b0b9a140635434a46aa98b0" 
}

source "virtualbox-iso" "ubuntu" {
  iso_url           = var.ubuntu_iso_url
  iso_checksum      = var.ubuntu_iso_checksum
  vm_name           = "ubuntu-22.04"
  guest_os_type     = "Ubuntu_64"
  ssh_username      = "ubuntu"
  ssh_password      = "ubuntu"
  ssh_timeout       = "60m"
  shutdown_command  = "echo 'ubuntu' | sudo -S shutdown -P now"
  http_directory = "C:/Program Files (x86)/packer/Packer_project/cloud-init.yaml"

  # Recursos mínimos
  cpus                    = 2
  memory                  = 2048
  disk_size               = 40960
  boot_command = ["<esc><esc> ", "install videolang=es ", " keyboard-configuration/layout=es ", "netcfg/do_netcfg=true ", "netcfg/get_netcfg=true ", "ssh/setup=true ", "<enter>"]
}

build {
  sources = ["source.virtualbox-iso.ubuntu"]

  provisioner "shell" {
    execute_command = "echo 'ubuntu' | {{.Vars}} sudo -S -E bash '{{.Path}}'"
    script          = "C:/Program Files (x86)/packer/Packer_project/install-ubuntu.sh"
    expect_disconnect = true
    valid_exit_codes = [0, 2300218]
  }

  post-processor "vagrant" {
    output = "ubuntu-22.04.box"
  }
}