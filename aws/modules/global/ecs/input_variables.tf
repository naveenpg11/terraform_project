# variable "container_image_id" {
#   description = "Container IMage ID"
# }

variable "container-image-id" {
  description = "Container IMage ID"
}

variable "container_name" {
  description = "Container name"
}

variable "task_cpu" {
  default = "500"
}
variable "task_memory" {
  default = "500"
}

variable "container_cpu" {
  default = 300
}

variable "container_memory" {
  default = 300
}

variable "container_port" {
  default = 8000
  description = "Container exposed port number"
}