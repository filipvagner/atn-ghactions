module "caf" {
  providers = {
    azurerm      = azurerm
    azurerm.vhub = azurerm.vhub
  }
  source             = "aztfmod/caf/azurerm"
  version            = "> 5.7.11"
  global_settings    = local.global_settings
  role_mapping       = local.role_mapping
  resource_groups    = local.resource_groups
  keyvaults          = local.keyvaults
  webapp             = local.webapp
  log_analytics      = local.log_analytics
  apim               = local.apim
}

module "naming" {
  source = "Azure/naming/azurerm"
  suffix = ["tada"]
}