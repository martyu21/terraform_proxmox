data "vault_kv_secret_v2" "proxmox_creds" {
  mount = "secret"
  name  = "proxmox_creds"
}

data "vault_kv_secret_v2" "awx_creds" {
  mount = "secret"
  name  = "awx_creds"
}