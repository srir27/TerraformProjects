variable "tags" {
  description = "Tags to be applied to all resources"
  type        = map(string)
  default = {
    Owner      = "sri"
    Deployment = "Terraform"
    Delete     = "Immediate"

  }
}
variable "rg_name" {
  description = "The name of the resource group"
  type        = string
  default     = "myResourceGroup"

}
variable "rg_location" {
  description = "The location of the resource group"
  type        = string
  default     = "West Europe"

}

# Network variables
variable "vnet_name" {
  type = string
}
variable "address_space" {
  type = list(string)
}

variable "subnet_name" {
  type = string
}
variable "snet_space" {
  type = list(string)
}