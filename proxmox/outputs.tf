output "vm_pool" {
  value = var.vm_pool
}

output "healthcheck_hosts" {
  value = join(",", values({
    for k, v in proxmox_lxc.container :
    k => v.hostname
  }))
}