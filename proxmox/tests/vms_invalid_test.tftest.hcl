run "invalid_vm_name" {
  command = plan

  variables {
    vms = [
      {
        name   = "bad name with spaces"
        cores  = 2
        memory = 2048
      }
    ]
  }

  expect_failures = [
    var.vms
  ]
}

run "invalid_vm_cores" {
  command = plan

  variables {
    vms = [
      {
        name   = "validname"
        cores  = 0
        memory = 2048
      }
    ]
  }

  expect_failures = [
    var.vms
  ]
}