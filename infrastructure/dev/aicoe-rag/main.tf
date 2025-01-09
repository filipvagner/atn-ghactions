terraform {
  backend "azurerm" {}
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "> 3.100.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.43.0"
    }
    azapi = {
      source  = "azure/azapi"
      version = "~> 1.6.0"
    }
    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = "~> 1.2.0"
    }
    null = {
      source = "hashicorp/null"
    }
    random = {
      version = "~> 3.5.1"
      source  = "hashicorp/random"
    }
  }
  required_version = ">= 1.3.5"
}

provider "azapi" {
}

provider "azurerm" {
  features {}
  alias = "vhub"
}
provider "azurerm" {
  features {}
  subscription_id     = local.subscription_id
  storage_use_azuread = true
}

data "azurerm_client_config" "current" {}

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
  storage_accounts   = local.storage_accounts
  keyvaults          = local.keyvaults
  database           = local.database
  webapp             = local.webapp
  networking         = local.networking
  log_analytics      = local.log_analytics
  apim               = local.apim
  cognitive_services = local.cognitive_services
  search_services    = local.search_services
}

module "naming" {
  source = "Azure/naming/azurerm"
  suffix = ["tada"]
}

#region Service Plan
module "plan" {
  for_each = local.app_service_plans

  source  = "Azure/avm-res-web-serverfarm/azurerm"
  version = "0.2.0"

  name                   = each.key
  location               = each.value.location
  resource_group_name    = each.value.resource_group_name
  enable_telemetry       = false
  os_type                = each.value.os_type
  sku_name               = each.value.sku_name
  zone_balancing_enabled = each.value.zone_balancing_enabled
}
#endregion Service Plan

#region Web App
module "app" {
  for_each = local.web_apps

  source  = "Azure/avm-res-web-site/azurerm"
  version = "0.11.0"

  name                        = each.key
  location                    = each.value.location
  resource_group_name         = each.value.resource_group_name
  enable_telemetry            = false
  os_type                     = each.value.os_type
  kind                        = each.value.kind
  service_plan_resource_id    = each.value.service_plan_resource_id
  builtin_logging_enabled     = each.value.builtin_logging_enabled
  client_affinity_enabled     = each.value.client_affinity_enabled
  https_only                  = each.value.https_only
  enable_application_insights = false

  app_settings    = each.value.app_settings
  sticky_settings = each.value.sticky_settings
  site_config     = each.value.site_config
}
#endregion Web App

#region Function App
module "func" {
  for_each = local.func_apps

  source  = "Azure/avm-res-web-site/azurerm"
  version = "0.11.0"

  name                        = each.key
  location                    = each.value.location
  resource_group_name         = each.value.resource_group_name
  enable_telemetry            = false
  os_type                     = each.value.os_type
  kind                        = each.value.kind
  storage_account_name        = each.value.storage_account_name
  storage_account_access_key  = each.value.storage_account_access_key
  service_plan_resource_id    = each.value.service_plan_resource_id
  builtin_logging_enabled     = each.value.builtin_logging_enabled
  client_affinity_enabled     = each.value.client_affinity_enabled
  client_certificate_mode     = each.value.client_certificate_mode
  https_only                  = each.value.https_only
  enable_application_insights = false

  app_settings    = each.value.app_settings
  sticky_settings = each.value.sticky_settings
  site_config     = each.value.site_config
}
#endregion Function App

#region PaaS SQL
resource "azurerm_mssql_database" "sqldb_rag" {
  name           = "${module.naming.mssql_database.name}-rag"
  server_id      = module.caf.mssql_servers.sql_rag.id
  create_mode    = "Default"
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "BasePrice"
  max_size_gb    = 50
  sku_name       = "S1"
  zone_redundant = false

  tags = merge(
    local.global_settings.tags,
    {
      environment = "dev"
    }
  )
}
#endregion PaaS SQL

#region Azure OpenAI Service
# resource "azurerm_cognitive_account" "oai_rag" {
#   name                               = "oai-fiva-rag"
#   location                           = local.global_settings.regions.airegion
#   resource_group_name                = module.caf.resource_groups.rg_rag.name
#   kind                               = "OpenAI"
#   sku_name                           = "S0"
#   dynamic_throttling_enabled         = false
#   local_auth_enabled                 = true
#   custom_subdomain_name              = "oai-fiva-rag"
#   public_network_access_enabled      = true
#   outbound_network_access_restricted = false

#   tags = {
#     Acceptance = "Test"
#   }

#   network_acls {
#     default_action = "Allow"
#     ip_rules       = []
#   }
# }
#endregion Azure OpenAI Service

#region Document intelligence
# resource "azurerm_cognitive_account" "di_rag" {
#   name                               = "di-fiva-rag"
#   location                           = local.global_settings.regions.airegion
#   resource_group_name                = module.caf.resource_groups.rg_rag.name
#   kind                               = "FormRecognizer"
#   sku_name                           = "F0"
#   dynamic_throttling_enabled         = false
#   local_auth_enabled                 = true
#   custom_subdomain_name              = "di-fiva-rag"
#   public_network_access_enabled      = true
#   outbound_network_access_restricted = false

#   tags = {
#     Acceptance = "Test"
#   }

#   network_acls {
#     default_action = "Allow"
#     ip_rules       = []
#   }
# }
#endregion Document intelligence

#region AI Search
# resource "azurerm_search_service" "srch_rag" {
#   name                = "srch-fiva-rag"
#   location            = local.global_settings.regions["ai_region"]
#   resource_group_name = module.caf.resource_groups.rg_rag.name
#   sku                 = "basic"
#   semantic_search_sku = "free"

#   allowed_ips                              = []
#   authentication_failure_mode              = null
#   customer_managed_key_enforcement_enabled = false
#   hosting_mode                             = "default"
#   local_authentication_enabled             = true
#   partition_count                          = 1
#   public_network_access_enabled            = true
#   replica_count                            = 1
# }
#endregion AI Search

#region Azure AI Services
# resource "azurerm_ai_services" "ais_rag_branch" {
#   name                = "ais-fiva-rag-branch"
#   location            = local.global_settings.regions.airegion
#   resource_group_name = module.caf.resource_groups.rg_rag.name
#   sku_name            = "S0"

#   tags = {
#     Acceptance = "Test"
#   }
# }
#endregion Azure AI Services