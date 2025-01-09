resource "azurerm_resource_group" "this" {
  name     = "ado-selfhosted-agent"
  location = var.location
}