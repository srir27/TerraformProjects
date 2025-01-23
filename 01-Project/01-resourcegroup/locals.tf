locals {
  rgname            = replace(lower(var.rgname), " ", "-")
  timestamp         = timestamp()
  timefmt           = formatdate("DD-MMM-YY", local.timestamp)
  time_tags         = { modified_on : local.timefmt }
  tags              = merge(var.default_tags, local.time_tags)
}