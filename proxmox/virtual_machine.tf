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

resource "http" "launch" {
  url    = "${var.awx_url}/api/v2/job_templates/${var.awx_job_template_id}/launch/"
  method = "POST"

  request_headers = {
    Authorization = "Bearer ${var.awx_token}"
    Content-Type  = "application/json"
  }

  request_body = jsonencode({
    extra_vars = {
      hostname = module.vm.hostname
      ip       = module.vm.ip_address
    }
  })
}

resource "http" "status" {
  url    = "${var.awx_url}/api/v2/jobs/${jsondecode(resource.http.launch.response_body).id}/"
  method = "GET"

  request_headers = {
    Authorization = "Bearer ${var.awx_token}"
  }

  retry {
    attempts = 100
    delay    = 10
    until    = contains(["successful", "failed"], jsondecode(self.response_body).status)
  }
}


resource "proxmox_pool" "example" {
  poolid  = "example-pool" 
  comment = "Example of a pool"
}