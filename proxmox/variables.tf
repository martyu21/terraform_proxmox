
variable "proxmox_node" {
  type        = string
  description = "Defines the proxmox node"
  default     = "westside"
}

variable "template_name" {
  type        = string
  description = "Defines the template to clone from"
  default     = "testvm01"
}

variable "vm_cores" { default = 2 }
variable "vm_memory" { default = 4096 }
variable "vm_disk_size" { default = "40G" }
variable "vm_storage" { default = "local-lvm" }
variable "vm_bridge" { default = "vmbr0" }

variable "vms" {
  description = "VM definitions"
  type = list(object({
    name   = string
    cores  = number
    memory = number
  }))
}