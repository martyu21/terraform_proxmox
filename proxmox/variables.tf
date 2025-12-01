variable "proxmox_node" { default = "pve" }
variable "vm_name" {}
variable "template_name" {}
variable "vm_cores" { default = 2 }
variable "vm_memory" { default = 4096 }
variable "vm_disk_size" { default = "40G" }
variable "vm_storage" { default = "local-lvm" }
variable "vm_bridge" { default = "vmbr0" }