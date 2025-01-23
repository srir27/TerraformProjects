variable "subscription_id" {
  type = string
}


variable "environment" {
  type    = string
  default = "dev"
  validation {
    condition     = contains(["dev", "stage", "prod"], var.environment)
    error_message = "Enter a valid env name"
  }
}
variable "suffix" {
  type    = string
  default = "tfdeploy"

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
variable "vnet_name" {
  type = string
}

variable "address_space" {
  type        = list(string)
  description = "Please enter values in CIDR range"
}
variable "lbname" {
  type = string
}

variable "subnet_name" {
  type = map(string) #Since we are using for_each.
}

variable "vmssname" {
  type = string

}

variable "admin_password" {
  type      = string
  sensitive = true
}
variable "admin_username" {
  type = string
}
