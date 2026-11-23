output "vm_pool" {
  value = var.vm_pool
}

output "hostnames" {
  value = {
    for k, v in proxmox_lxc.container :
    k => v.hostname
  }
}