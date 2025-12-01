terraform {
  required_providers {
    proxmox = {
      source = "Telmate/proxmox"
      version = "3.0.2-rc05"
    }
  }
}

provider "vault" {
  address = "http://127.0.0.1:8200/"
}

provider "proxmox" {
  pm_api_url      = data.vault_kv_secret_v2.proxmox_creds.data["endpoint"]
  pm_user         = data.vault_kv_secret_v2.proxmox_creds.data["username"]
  pm_password     = data.vault_kv_secret_v2.proxmox_creds.data["password"]
  pm_tls_insecure = true
}
