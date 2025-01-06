resource "azurerm_resource_group" "this" {
  name     = "ado-selfhosted-agent"
  location = var.location
}

resource "random_integer" "this" {
  max = 99999
  min = 10000
}

locals {
  agent_name = "azp-agent-${random_integer.this.result}"
  agent_pool = var.azp_pool != "" ? var.azp_pool : "aci-agents"
  azp_url    = "https://dev.azure.com/${var.azp_org_name}"
}

module "containerregistry" {
  source  = "Azure/avm-res-containerregistry-registry/azurerm"
  version = "0.3.1"

  name                = var.container_registry_name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  sku                 = "Basic"
  admin_enabled      = true
  zone_redundancy_enabled = false # need to override this default setting because zone redundancy isn't supported on Basic SKU.
  enable_telemetry        = false
}

resource "azurerm_container_group" "this" {
  name                = local.agent_name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  ip_address_type     = "Public"
  dns_name_label      = local.agent_name
  os_type             = "Linux"

  image_registry_credential {
    username = "atntestregistry"
    password = module.containerregistry.resource.admin_password
    server   = "atntestregistry.azurecr.io"
  }

  container {
    name   = "azp-agent"
    image  = var.agent_image
    cpu    = "1.0"
    memory = "2.0"
    ports {
      port     = 80
      protocol = "TCP"
    }
    environment_variables = {
      AZP_URL        = local.azp_url
      AZP_TOKEN      = var.azp_token
      AZP_POOL       = local.agent_pool
      AZP_AGENT_NAME = local.agent_name
    }
  }

  depends_on = [azuredevops_agent_pool.this]

}

resource "azuredevops_agent_pool" "this" {
  # If azp_pool is not set, create a pool for the agent
  count          = var.azp_pool == "" ? 1 : 0
  name           = local.agent_pool
  auto_provision = true
  auto_update    = false
}