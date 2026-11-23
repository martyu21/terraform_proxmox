output "vm_pool" {
  value = var.vm_pool
}

output "hostnames" {
  value = join(",", values({
    for k, v in proxmox_lxc.container :
    k => v.hostname
  }))
}

output "container_ids_csv" {
  value = join(",", [
    for c in proxmox_lxc.container : c.vmid
  ])
}