output "vm_pool" {
  value = var.vm_pool
}

output "hostnames" {
  value = join(",", values({
    for k, v in proxmox_lxc.container :
    k => v.hostname
  }))
}