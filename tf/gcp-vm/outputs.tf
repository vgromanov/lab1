output "vm_name" {
  value = google_compute_instance.node.name
}

output "vm_ip" {
  value = google_compute_instance.node.network_interface.0.access_config.0.nat_ip
}
