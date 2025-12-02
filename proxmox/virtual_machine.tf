resource "proxmox_vm_qemu" "win_vm" {
  for_each = { for vm in var.vms : vm.name => vm }

  name   = each.value.name
  target_node = var.proxmox_node
  clone       = var.template_name
  full_clone  = true

  memory = each.value.memory
  cpu { sockets = 1 }
  scsihw  = "virtio-scsi-pci"

  disk {
    type    = "disk"
    storage = var.vm_storage
    size    = var.vm_disk_size
    slot    = "ide0"
  }

  network {
    model  = "virtio"
    bridge = var.vm_bridge
    id     = 0
  }

  os_type = "windows"

  # Optional: set boot order
  boot = "order=ide0;net0"

  # Optional: enable guest agent if installed in template
  agent = 1

  # Optional: set static IP if using DHCP reservation or manual config
  ipconfig0 = "ip=dhcp"

  # Optional: set VM description
  description = "Windows VM cloned from template"
}