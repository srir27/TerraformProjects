variable "tags" {}
variable "rg_name" {
  type     = string
  nullable = false
}
variable "location" {
  type     = string
  nullable = false
}
variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
  default     = "tf-vnet"
}
variable "address_space" {
  description = "The address space for the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]

}
variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
  default     = "tf-subnet"
}
variable "snet_space" {
  description = "The address space for the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/24"]

}
