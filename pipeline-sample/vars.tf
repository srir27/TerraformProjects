variable "tags" {
  description = "Tags to be applied to all resources"
  type        = map(string)
  default     = {
    Owner      = "sri"
    Deployment = "Terraform"
    Delete   = "Immediate"
  
}
}
variable "subscription_id" {
  description = "The subscription ID to use for the provider"
  type        = string
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