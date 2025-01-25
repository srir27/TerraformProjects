
# A personal access token should be created in GitHub and the token should be used here
# Settings > Developer Settings > Personal Access Tokens > Generate new token with access to repo, workflow, or admin:repo_hook
# The token should be stored in a secure way. It should not be hardcoded in the code.
resource "azurerm_source_control_token" "scmtoken" {
  type  = "GitHub"
  token = var.githubtoken
  depends_on = [ azurerm_service_plan.asp ]
}

resource "azurerm_linux_web_app" "lnxapp" {
  name                = "lnxapp-${var.suffix}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_service_plan.asp.location
  service_plan_id     = azurerm_service_plan.asp.id
  depends_on = [ azurerm_service_plan.asp ]
  site_config {
    application_stack {
      python_version = "3.8"
    }
    
  }
  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
  }
}
# Below is the source control for the default web app slot (production)
resource "azurerm_app_service_source_control" "prodsrc" {
  app_id                 = azurerm_linux_web_app.lnxapp.id
  repo_url               = "https://github.com/srir27/python-docs-hello-world.git"
  branch                 = "master"
  depends_on = [ azurerm_linux_web_app.lnxapp, azurerm_source_control_token.scmtoken ]
    lifecycle {
    ignore_changes = [repo_url,branch]
  }

}
resource "azurerm_linux_web_app_slot" "slot2" {
  name           = "stage-${var.suffix}"
  app_service_id = azurerm_linux_web_app.lnxapp.id
  site_config {
    always_on = true
  }
  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
  }
}
#Source control for the staging slot (slot2)
resource "azurerm_app_service_source_control_slot" "stgsrc" {
  slot_id  = azurerm_linux_web_app_slot.slot2.id
  repo_url = "https://github.com/srir27/python-docs-hello-world.git"
  branch   = "green"
  depends_on = [ azurerm_linux_web_app_slot.slot2, azurerm_source_control_token.scmtoken ]
    lifecycle {
    ignore_changes = [repo_url,branch]
  }

}
