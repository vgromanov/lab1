variable "ssh_user" {
  type = string
}

variable "ssh_key" {
  type = string
}

variable "os_image" {
  type = string
}

variable "machine_type" {
  default = "f1-micro"
}

variable "vm_name" {
  type = string
}
