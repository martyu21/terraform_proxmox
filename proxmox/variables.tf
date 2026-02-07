
variable "proxmox_node" {
  type        = string
  description = "Defines the proxmox node"
  default     = "westside"
}

variable "template_name" {
  type        = string
  description = "Defines the template to clone from"
  default     = "testvm01"

  validation {
    condition = (
      length(var.template_name) > 0 &&
      can(regex("^[a-zA-Z0-9_-]+$", var.template_name))
    )
    error_message = "Template name must be a non-empty string containing only letters, numbers, dashes, or underscores."
  }
}

variable "vm_cores" {
  type        = number
  description = "Defines the number of cores"
  default     = 2

  validation {
    condition = (
      var.vm_cores >= 1 &&
      var.vm_cores <= 64
    )
    error_message = "vm_cores must be a number between 1 and 64."
  }
}

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

  validation {
    condition = alltrue([
      for vm in var.vms :
      (
        length(vm.name) > 0 &&
        can(regex("^[a-zA-Z0-9_-]+$", vm.name)) &&
        vm.cores >= 1 &&
        vm.cores <= 64 &&
        vm.memory >= 512 &&
        vm.memory <= 262144
      )
    ])
    error_message = "Each VM must have a valid name (letters, numbers, dashes, underscores), cores between 1–64, and memory between 512–262144 MB."
  }
}
