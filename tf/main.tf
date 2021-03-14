provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}

resource "google_compute_project_default_network_tier" "default" {
  network_tier = "STANDARD"
}

resource "google_compute_firewall" "default_allow_http" {
  name    = format("${var.env}-allow-http")
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
}

module "gcp_vm" {
  for_each = toset(var.vms)
  source = "./gcp-vm"
  os_image = var.os_image
  ssh_user = var.ssh_user
  ssh_key = var.ssh_key
  mahicne_type = var.machine_type
  vm_name = each.key
}

output "inventory" {
  value = {
    for instance in module.gcp_vm:
    instance.vm_name => instance.vm_ip
  }
}
