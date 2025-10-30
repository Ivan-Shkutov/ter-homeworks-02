# Ex.3
variable "vm_db_zone" {
  type = string
  default = "ru-central1-b"
  description = "Working zone"
}

/*
variable "vm_db_name" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "VM names"
}
*/

variable "vm_db_platform_id" {
  type = string
  default = "standard-v3"
  description = "ID of virtual platform"
}

/*
variable "vm_db_hw_cores" {
  type = number
  default = 2
  description = "Number of virtual cores"
}

variable "vm_db_hw_memory" {
  type = number
  default = 2
  description = "The amount of RAM"
}

variable "vm_db_core_frac" {
  type = number
  default = 20
  description = "Limiting peak CPU performance"
}

 */
variable "vm_db_hw_preemptible" {
  type = bool
  default = true
  description = "Intermittent VM operation"
}
variable "vm_db_hw_nat" {
  type = bool
  default = true
  description = "NAT"
}

/*
variable "vm_db_hw_serial_port_enable" {
  type = number
  default = 1
  description = "Activate the serial port for remote access"
}
 */
