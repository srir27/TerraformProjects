variable "environment" {
  type    = string
  default = "dev"
  validation {
    condition     = contains(["dev", "stage", "prod"], var.environment)
    error_message = "Enter a valid env name"
  }
}

variable "rgname" {
  type = string

}
variable "location" {
  type    = string
  default = "North Europe"
  validation {
    condition     = contains(["East US", "North Europe", "Central India"], var.location)
    error_message = "Please enter allowed locations"
  }
}
variable "default_tags" {
  type = map(string)
  default = {
    owner      = "rsb"
    deployment = "terraform"
  }
}
# In 03-vmss module

variable "subnet_id_from_network" {
  type = string
}

variable "backendpool" {
}

variable "probe" {
}
variable "ssh_rule" {

}
variable "vmssname" {
  type = string
  
}
variable "admin_username" {
  type = string
}
variable "admin_password" {
    type = string
    sensitive = true
  
}

