locals {
  rgname            = replace(lower(var.rgname), " ", "-")
  timestamp         = timestamp()
  timefmt           = formatdate("DD-MMM-YY", local.timestamp)
  time_tags         = { modified_on : local.timefmt }
  tags              = merge(var.default_tags, local.time_tags)
  nsg1_name         = "allownsg-tf"
  lb_publicip_name  = "lbpublicip-tf" # Public IP name used by loadblncr. 
  loadbalancer_name = "vmloadbalancer-tf"
  nat_publicip_name = "vmnatgw-tf"



}
