vms = [
  { name = "M02", cores = 2, memory = 2048 },
  { name = "M03", cores = 2, memory = 2048 }
]

proxmox_node        = "westside"
template_name       = "testvm01"
vm_disk_size        = "40G"
vm_storage          = "local-lvm"
vm_bridge           = "vmbr0"