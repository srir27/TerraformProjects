subscription_id = "value-for-subscription-id"
rg_name         = "tf-rg-ado"
rg_location     = "West Europe"
tags = {
  Owner      = "sri"
  Deployment = "Terraform"
  Delete     = "Immediate"
}

vnet_name     = "tf-vnet-ado"
address_space = ["10.0.0.0/16"]
subnet_name   = "tf-subnet-ado"
snet_space    = ["10.0.0.0/24"]