# Configuración de Packer
packer {
  required_plugins {
    vmware = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/vmware"
    }
  }
}

# Configuración del builder
source "vmware-iso" "windows_server" {
  iso_url              = "file:///C:/isos/SERVER_EVAL_x64FRE_es-es.iso"   
  iso_checksum         = "052c7d7785a99db7c5ff710090050fbd424a2f17312f0c6463e959e4e19cee98"      
  communicator         = "winrm"
  winrm_username       = "Administrator"
  winrm_password       = "Windowsserver2022"
  winrm_timeout        = "6h"

  vm_name              = "Windows-Server"
  guest_os_type        = "windows9-64"
  shutdown_command     = "shutdown /s /f /t 0"
  
  # Configuración de hardware
  disk_size            = 50000  # En MB (50GB)
  memory               = 4096   # En MB (4GB)
  cpus                 = 2

  # Autounattended
  floppy_files = [
    "./Autounattend.xml"  
  ]

  # Comando de arranque 
  boot_command = [
    "<tab><wait><enter>"
  ]
}

# Configuración del provisioner
build {
  sources = ["source.vmware-iso.windows_server"]

  provisioner "windows-shell" {
    script = "scripts\\setup.ps1"
  }
}
