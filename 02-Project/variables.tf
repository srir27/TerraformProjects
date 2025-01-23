variable "subscription_id" {
  type = string
}

variable "rgname" {
  type = list(string)
  default = [ "rg1","rg2" ]
}

variable "location" {
  type = list(string)
  default = [ "eastus","northeurope" ]
}

variable "vname1" {
  default = "vnet1"
}
variable "address_space1" {
  type = list(string)
  default = [ "10.0.0.0/16" ]
}
variable "subnet1" {
  type = list(string)
  default = [ "subnet1A"]
}
variable "subnet_space1" {
  type = list(string)
    default = ["10.0.0.0/24"]
}

variable "vname2" {
  default = "vnet2"
}
variable "address_space2" {
  type = list(string)
  default = [ "10.1.0.0/16" ]
}

variable "subnet2" {
  type = list(string)
  default = [ "subnet2A" ]
}
variable "subnet_space2" {
  type = list(string)
    default = [ "10.1.0.0/24"] 
}

variable "vm1count" {
  type = number
  default = 1
}
variable "vm2count" {
  type = number
  default = 1
}
