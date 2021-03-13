resource "google_compute_instance" "node" {
  name = var.vm_name
  machine_type = var.machine_type
  boot_disk {
    initialize_params {
      image = var.os_image
    }
  }
  network_interface {
    network = "default"
    access_config {
      network_tier = "STANDARD"
    }
  }
  metadata = {
    ssh-keys = join(":", [var.ssh_user, var.ssh_key])
  }
}
