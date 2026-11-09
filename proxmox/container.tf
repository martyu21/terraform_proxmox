resource "proxmox_lxc" "container" {
  target_node = var.target_node
  hostname    = var.hostname

  clone = var.template_name

  cores  = 2
  memory = 2048

  rootfs {
    storage = "local-lvm"
    size    = "20G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "dhcp"
  }

  start = true

  ssh_public_keys = file(var.public_key_file)
}