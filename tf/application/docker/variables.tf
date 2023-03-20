
variable "container_name" {
  description = "The name of the container"
  type        = string
}

variable "image" {
  description = "The image to use for the container"
  type        = string
}

variable "environment_variables" {
  description = "The environment variables to use for the container"
  type        = list(string)
}

variable "exposed_ports" {
  description = "Whether to expose ports for the container to the host"
  type        = bool
  default     = false
}

variable "internal_port" {
  description = "The internal port to expose for the container"
  type        = number
}

variable "external_port" {
  description = "The external port to expose for the container"
  type        = number
}

variable "advanced_networking" {
  description = "Whether to connect the container to a network"
  type        = bool
  default     = false
}

variable "network_name" {
  description = "The name of the network to connect the container to"
  type        = string
}
