provider "azurerm" {
  features {}
  alias = "vhub"
}
provider "azurerm" {
  features {}
  subscription_id     = local.subscription_id
  storage_use_azuread = true
}

provider "azapi" {
}