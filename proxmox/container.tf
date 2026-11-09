resource "proxmox_lxc" "container" {
  for_each = { for ct in var.containers : ct.name => ct }
  
  hostname    = each.value.name
  target_node = var.proxmox_node
  full = true
  clone = var.container_template_name

  cores  = each.value.cores
  memory = each.value.memory

  rootfs {
    storage = var.container_storage
    size    = var.container_disk_size
  }

  network {
    name   = "eth0"
    bridge = var.container_bridge
    ip     = "dhcp"
  }

  pool = var.container_pool

  start = true
  onboot = true

  description = "LXC container cloned from template"
}