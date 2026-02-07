run "valid_vms" {
  command = plan

  variables {
    vms = [
      {
        name   = "web01"
        cores  = 4
        memory = 4096
      },
      {
        name   = "db01"
        cores  = 8
        memory = 8192
      }
    ]
  }

  assert {
    condition     = length(plan.resource_changes) > 0
    error_message = "Expected resources to be created, but the plan was empty."
  }
}