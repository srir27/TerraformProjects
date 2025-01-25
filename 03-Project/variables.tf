variable "suffix" {
  type = string
  default = "tfdeploy"
}
variable "subscription_id" {
  type = string
  
}

variable "githubtoken" {
  type = string
  
}
variable "rgname" {
  type = string
  default = "rg1"
}

variable "location" {
  type = string
  default = "northeurope"
  validation {
    condition = contains(["eastus","northeurope"], var.location)
    error_message = "Location not allowed"
  }
}

variable "aspname" {
  type = string
  default = "asp1"
}
variable "webappname" {
  type = string
  default = "webapp1"
}