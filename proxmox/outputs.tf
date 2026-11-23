output "vm_pool" {
  value = var.vm_pool
}

output "healthcheck_url" {
  value = "http://${proxmox_lxc.container.hostname}/"
}